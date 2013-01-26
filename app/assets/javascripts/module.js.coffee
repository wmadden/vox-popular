namespace 'vp'

vp.module = angular.module('vp.module', [])
    .factory('SoundCloud', ->
        SC.initialize({
            client_id: "d1be0c623cac50d0d6e30cfa95e4c47c"
        })
        SC
    )
