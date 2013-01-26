vp.patron.module
    .factory('PlaylistResource', ['$resource', ($resource) ->
        $resource(
            '/patron/playlists/:id',
            { id: '@id' }
        )
    ])