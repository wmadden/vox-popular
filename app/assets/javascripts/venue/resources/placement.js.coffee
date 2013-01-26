vp.venue.module
    .factory('PlacementResource', ['$resource', ($resource) ->
        resource = $resource(
            '/venue/playlists/:playlist_id/placements/:id/:action',
            { playlist_id: '@playlist_id', id: '@id' },
            {
                putPlayStarted: {
                    method: 'PUT',
                    params: {
                        action: 'start_playing_track'
                    }
                }
                putPlayFinished: {
                    method: 'PUT',
                    params: {
                        action: 'finish_playing_track'
                    }
                }
            }
        )
        _.extend( resource.prototype, {
            data: ->
                {
                    placement: {
                        state: this.state
                    }
                }
        })

        resource
    ])