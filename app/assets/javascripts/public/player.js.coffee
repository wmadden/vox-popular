namespace 'vp.public'

class vp.public.Player
    constructor: ($scope, SoundCloud) ->
        _.extend($scope, {
            findTracks: (query) =>
                SoundCloud.get('/tracks', { q: query }, (tracks) =>
                    $scope.tracks = tracks
                    if !$scope.$$phase
                        $scope.$digest()
                )

            chooseTrack: (track) =>
                $scope.currentTrack = track

            playSelectedTrack: =>
                SoundCloud.stream('/tracks/' + $scope.currentTrack.id, (track) =>
                    @track = track
                    @track.play()
                )

            stopPlaying: =>
                @track.stop()
        })

        $('.track-search').typeahead({
            source:  $scope.getTypeaheadOptions
            updater: $scope.chooseTypeaheadOption
        })

vp.public.Player.$inject = ['$scope', 'SoundCloud']