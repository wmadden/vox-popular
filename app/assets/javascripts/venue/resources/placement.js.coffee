vp.venue.module
    .factory('PlacementResource', ['$resource', '$http', ($resource, $http) ->
        resource = $resource(
            '/venue/playlists/:playlist_id/placements/:id/:action',
            { playlist_id: '@playlist_id', id: '@id' },
            { } # Extra actions
        )
        _.extend( resource.prototype, {
            data: ->
                {
                    placement: {
                        state: this.state
                    }
                }

            putPlayStarted: ->
                url = '/venue/playlists/' + this.playlist_id + '/placements/' + this.id + '/start_playing_track'
                $http.put(url, {})

            putPlayFinished: ->
                url = '/venue/playlists/' + this.playlist_id + '/placements/' + this.id + '/finish_playing_track'
                $http.put(url, {})
        })

        resource
    ])