vp.venue.module
    .factory('PlaylistResource', ['$resource', ($resource) ->
        $resource(
            '/venue/playlists/:id',
            { id: '@id' }
        )
    ])