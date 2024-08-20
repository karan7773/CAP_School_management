sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'studentmanage/test/integration/FirstJourney',
		'studentmanage/test/integration/pages/GetStudentsList',
		'studentmanage/test/integration/pages/GetStudentsObjectPage',
		'studentmanage/test/integration/pages/GetEnrollmentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, GetStudentsList, GetStudentsObjectPage, GetEnrollmentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('studentmanage') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGetStudentsList: GetStudentsList,
					onTheGetStudentsObjectPage: GetStudentsObjectPage,
					onTheGetEnrollmentsObjectPage: GetEnrollmentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);