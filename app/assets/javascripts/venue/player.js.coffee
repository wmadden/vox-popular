namespace 'vp.venue'

class vp.venue.Player
    constructor: ($scope, $http, SoundCloud, PlaylistResource, PlacementResource) ->

        updateView = ->
            if !$scope.$$phase
                $scope.$digest()

        getPlaylist = =>
            deferred = $.Deferred()
            $scope.playlist = PlaylistResource.get(
                { id: $scope.playlist_id },
                (args...) ->
                    deferred.resolve(args...)

                    upcoming_placements = [
                        { soundcloud_track_id: 76523239, url: "/venue/playlists/1/placements/2" },
                        { soundcloud_track_id: 76523237, url: "/venue/playlists/1/placements/3" },
                        { soundcloud_track_id: 1917917, url: "/venue/playlists/1/placements/4" }
                    ]

                    $scope.playlist.now_playing = new PlacementResource($scope.playlist.now_playing)
                    expandTrack($scope.playlist.now_playing).done(updateView)

                    # Convert the flat objects into placement resources
                    upcoming_placements = _.map( upcoming_placements, (placement) ->
                        placement = new PlacementResource(placement)
                        expandTrack(placement).done(updateView)
                        placement
                    )

                    $scope.playlist.upcoming_placements = upcoming_placements
                (args...) -> deferred.reject(args...)
            )
            deferred.promise()

        expandTrack = (placement) ->
            getTrack(placement.soundcloud_track_id)
                .done( (info) =>
                    placement.track = info
                )

        getTrack = (id) =>
            deferred = $.Deferred()
            SoundCloud.get(
                '/tracks/' + id,
                {},
                (result) -> deferred.resolve(result),
                (args...) -> deferred.reject(args...)
            )
            deferred.promise()

        _.extend($scope, {
            getPlaylist: -> $scope.playlist.get()

            play: ->
                $scope.playlist.now_playing.state = 'playing'
                $scope.playlist.now_playing.$putPlayStarted()

                SoundCloud.stream(
                    '/tracks/' + $scope.playlist.now_playing.soundcloud_track_id,
                    {
                        onload: ->
                            this.onPosition(this.duration, (eventPosition) ->
                                $scope.next()
                            )
                    },
                    (track) =>
                        $scope.playlist.now_playing.soundcloudTrack = track
                        $scope.playlist.now_playing.soundcloudTrack.play()
                )

            stop: ->
                $scope.playlist.now_playing.soundcloudTrack.stop()

            next: ->
                $scope.playlist.now_playing.state = 'stopped'
                $scope.playlist.now_playing.$putPlayFinished()
                getPlaylist().done( ->
                    $scope.play()
                )

        })

        getPlaylist()

vp.venue.Player.$inject = ['$scope', '$http', 'SoundCloud', 'PlaylistResource', 'PlacementResource']