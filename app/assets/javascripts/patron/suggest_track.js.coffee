namespace 'vp.patron'

class vp.patron.SuggestTrack
    constructor: ($scope, SoundCloud) ->
        _.extend($scope, {
            findTracks: (query) =>
                SoundCloud.get('/tracks', { q: query }, (tracks) =>
                    $scope.tracks = tracks
                    if !$scope.$$phase
                        $scope.$digest()
                )

            chooseTrack: (track) =>
                console.log("Chose track", track)
        })

vp.patron.SuggestTrack.$inject = ['$scope', 'SoundCloud']