vp.venue.module
    .factory('PlacementResource', ['$resource', ($resource) ->
        resource = $resource(
            '/venue/playlists/:playlist_id/placements/:id',
            { playlist_id: '@playlist_id', id: '@id' }
        )
        _.extend( resource.prototype, {
            data: ->
                {
                    state: '@state'
                }
        })

        resource
    ])