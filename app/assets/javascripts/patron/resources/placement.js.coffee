vp.patron.module
    .factory('PlacementResource', ['$resource', ($resource) ->
        resource = $resource(
            '/patron/playlists/:playlist_id/placements/:id/:action',
            { playlist_id: '@playlist_id', id: '@id' },
            {
                upvote: {
                    method: 'POST',
                    params: {
                        action: 'upvote'
                    }
                }
                dismiss: {
                    method: 'POST',
                    params: {
                        action: 'dismiss'
                    }
                }
            }
        )
        _.extend( resource.prototype, {
            data: ->
                {
                    placement: {
                        state: this.state,
                        track: {
                            sc_track_id: this.track.soundcloud_track_id
                        }
                    }
                }
        })

        resource
    ])