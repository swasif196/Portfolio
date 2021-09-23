/*
Sohaib Wasif
*/

$(document).ready(function () {

    // Load Links
    clippy.load('Links', function(agent) {
        // Do anything with the loaded agent
        agent.moveTo(575,200);
        agent.show();
        agent.speak("Welcome to CIS 3210 Assignment 2!");
        $('#artsy-button').click(function () {
          agent.play('GetArtsy');
          agent.speak("Aren't I Cute!!!!");
        });
      
        //Replace with a Links animation
        $('#alert-button').click(function () {
            agent.play('Alert');
            agent.speak("MEOW!!!");
        });
    });
        
});