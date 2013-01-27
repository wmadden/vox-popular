namespace 'vp.venue'

class vp.venue.Player
    constructor: ($scope, $http, SoundCloud, PlaylistResource, PlacementResource) ->
        playlist = null

        init = ->
            playlist = new PlaylistResource({ id: $scope.playlist_id })
            $scope.playlist = playlist
            refreshPlaylist().done( -> updateView() )

        updateView = ->
            if !$scope.$$phase
                $scope.$digest()

        initialisePlaylist = (playlist) ->
            pendingOperations = []

            if playlist.now_playing?
                playlist.now_playing = new PlacementResource(playlist.now_playing)
                pendingOperations.push( expandTrack(playlist.now_playing) )

            # Convert the flat objects into placement resources
            upcoming_placements = _.map( playlist.upcoming_placements, (placement) ->
                placement = new PlacementResource(placement)
                pendingOperations.push( expandTrack(placement) )
                placement
            )

            playlist.upcoming_placements = upcoming_placements

            $.when.apply($, pendingOperations).promise()

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

        refreshPlaylist = ->
            deferred = $.Deferred()
            playlist.$get(
                ->
                    initialisePlaylist(playlist).done( ->
                        deferred.resolve()
                    )
                ,
                (args...) ->
                    deferred.reject(args...)
            )
            deferred.promise()

        play = ->
            playlist.now_playing.state = 'playing'
            playlist.now_playing.putPlayStarted()

            SoundCloud.stream(
                '/tracks/' + playlist.now_playing.soundcloud_track_id,
                {
                onload: ->
                    this.onPosition(this.duration, (eventPosition) ->
                        next()
                    )
                },
            (track) =>
                playlist.now_playing.soundcloudTrack = track
                playlist.now_playing.soundcloudTrack.play()
            )

        stop = ->
            playlist.now_playing.soundcloudTrack.stop()

        next = ->
            if playlist.now_playing.state == 'playing'
                stop()
            playlist.now_playing.state = 'stopped'
            playlist.now_playing.putPlayFinished()
            refreshPlaylist().done( ->
                play()
                updateView()
            )

        _.extend($scope, {
            refreshPlaylist: -> refreshPlaylist()

            play: play

            stop: stop

            next: next
        })

        init()

vp.venue.Player.$inject = ['$scope', '$http', 'SoundCloud', 'PlaylistResource', 'PlacementResource']