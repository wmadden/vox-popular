namespace 'vp.patron'

class vp.patron.SuggestTrack
    constructor: ($scope, SoundCloud, PlacementResource) ->
        _.extend($scope, {
            findTracks: (query) =>
                SoundCloud.get('/tracks', { q: query }, (tracks) =>
                    $scope.tracks = tracks
                    if !$scope.$$phase
                        $scope.$digest()
                )

            chooseTrack: (track) =>
                PlacementResource.create({
                    playlist_id: $scope.playlist_id
                    placement: {
                        track_attributes: {
                            sc_track_id: track.id
                        }
                    }
                })
                $('#suggest-track-modal').modal('hide')
        })

vp.patron.SuggestTrack.$inject = ['$scope', 'SoundCloud', 'PlacementResource']