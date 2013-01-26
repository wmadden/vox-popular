namespace 'vp.venue'

class vp.venue.Player
    constructor: ($scope, $http, SoundCloud, PlaylistResource) ->

#        $scope.latestAttentionRequest = AttentionRequestResource.get({ id: 'latest' }, (-> updateState()),
#        (-> updateState()))

        updateView = ->
            if !$scope.$$phase
                $scope.$digest()

        getPlaylist = =>
            deferred = $.Deferred()
            $scope.playlist = PlaylistResource.get(
                { id: 1 },
                (args...) ->
                    deferred.resolve(args...)

                    $scope.playlist.upcoming_placements = [
                        { soundcloud_track_id: 76523239 },
                        { soundcloud_track_id: 76523237 },
                        { soundcloud_track_id: 1917917 }
                    ]

                    _.each([$scope.playlist.currently_playing_track].concat($scope.playlist.upcoming_placements),
                        (placement) ->
                            expandTrack(placement).done(updateView)
                        )
                (args...) -> deferred.reject(args...)
            )
            deferred.promise()

        expandTrack = (track) ->
            getTrack(track.soundcloud_track_id)
                .done( (info) =>
                    _.extend(track, info)
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
                SoundCloud.stream(
                    '/tracks/' + $scope.playlist.currently_playing_track.soundcloud_track_id,
                    {
                        onload: ->
                            this.onPosition(this.duration, (eventPosition) ->
                                getPlaylist().done(->
                                    $scope.play()
                                )
                            )
                    },
                    (track) =>
                        $scope.playlist.currently_playing_track.soundcloudTrack = track
                        $scope.playlist.currently_playing_track.soundcloudTrack.play()
                )

            stop: ->
                $scope.playlist.currently_playing_track.soundcloudTrack.stop()
        })

        getPlaylist()

vp.venue.Player.$inject = ['$scope', '$http', 'SoundCloud', 'PlaylistResource']