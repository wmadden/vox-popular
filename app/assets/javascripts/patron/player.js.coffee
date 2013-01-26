namespace 'vp.patron'

class vp.patron.Player
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
                    {
                        playlist_id: $scope.playlist_id,
                        id: 1,
                        soundcloud_track_id: 76523239
                    },
                    {
                        playlist_id: $scope.playlist_id,
                        id: 3,
                        soundcloud_track_id: 76523237
                    },
                    {
                        playlist_id: $scope.playlist_id,
                        id: 4,
                        soundcloud_track_id: 1917917
                    },
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
                $scope.playlist.unvoted_placements = upcoming_placements

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
            upvote: (placement) ->
                placement.$upvote()
                $scope.playlist.unvoted_placements = _.without($scope.playlist.unvoted_placements, placement)
            dismiss: (placement) ->
                placement.$dismiss()
                $scope.playlist.unvoted_placements = _.without($scope.playlist.unvoted_placements, placement)
        })

        getPlaylist()

vp.patron.Player.$inject = ['$scope', '$http', 'SoundCloud', 'PlaylistResource', 'PlacementResource']