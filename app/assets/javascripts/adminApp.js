function inProfile(station, profile_id) {
	if (!profile_id) {
		return (false);
	} else {
		return (station.profiles.indexOf(profile_id) >= 0);
	}
};

var adminApp = angular.module("adminApp", ['ngResource']);

adminApp.controller("BuoyCtrl", function($scope, $http, Station, Region, Profile) {

	$scope.stations = Station.query();
	$scope.regions = Region.query(function() {
		$scope.selectedRegion = $scope.regions[0].id;
	});

	$scope.profiles = Profile.query();

	$scope.regionChange = function() {
		$scope.selectedProfile = null;
	};

	$scope.foundInProfile = function(profile_id) {
		console.log('profile_id', profile_id);
		return (function(station) {
			return (inProfile(station, profile_id));
		} );
	};
});

adminApp.factory('Station', function($resource) {
	console.log('station factory');
	return $resource('/stations/:id.json', {
		id : '@id'
	});
});

adminApp.factory('Profile', function($resource) {
	return $resource('/profiles/:id.json', {
		id : '@id'
	});
});

adminApp.factory('Region', function($resource) {
	return $resource('/regions/:id.json', {
		id : '@id'
	});
}); 