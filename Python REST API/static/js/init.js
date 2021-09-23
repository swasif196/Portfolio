/*
Sohaib Wasif
*/

$(document).ready(function() {
    
     $('#submit').click(function(event) {
        event.preventDefault();
        var x = document.getElementById("tsx");
        var y = document.getElementById("nyse");

         if(document.getElementById("symbol").value === "" || x.checked === false && y.checked === false ){
            document.getElementById("disp").innerHTML = "<display>Please Enter A Valid Symbol And Select A Stock Exchange</display>";
        }
        else{
            var sym = document.getElementById("symbol").value;
            if(x.checked === true){
                sym+= ".to"
            }
            $.ajax({
                data : {
                    symbol : sym,
                },
                type : 'GET',
                url : '/value'
            })
            .done(function(result) {
                console.log(result);
                res = JSON.parse(result);
                console.log(res);

                if (res.error) {
                    document.getElementById("disp").innerHTML = "<label>You Entered Invalid Data</label>";
                }
                else {
                    console.log(res);
                    
                    if (res.postMarketPrice === null){
                        postval = 'NA';
                    }
                    else{
                        postval = res.postMarketPrice + " " + res.currency;
                    }
                    if (res.marketState === "PRE" || res.marketState == "PREPRE"){
                        state = 'Pre-trading'
                    }
                    else if(res.marketState === "POST" || res.marketState == "POSTPOST"){
                        state = 'Post-trading';
                    }
                    else{
                        state = res.marketState;
                    }
                    
                    if(x.checked === true){
                        document.getElementById("disp").innerHTML = "<table class=\"center\">\
                            <tr>\
                            <th colspan=2>" + res.longName + " (" + res.symbol +")</th>\
                            </tr>\
                            <tr>\
                            <th colspan=2>Value: "+ res.regularMarketPrice + " " + res.currency + " (" + res.fullExchangeName + ")</th>\
                            </tr>\
                            <tr>\
                            <td>Post Market Price: "+ postval + "</td>\
                            <td>Exchange: " + state + "</td>\
                            </tr>\
                            <tr>\
                            <td>Open: "+ res.regularMarketOpen + " " + res.currency + "</td>\
                            <td>Previous Close: "+ res.regularMarketPreviousClose + " " + res.currency + "</td> \
                            </tr>\
                            <tr>\
                            <td>Day High: "+ res.regularMarketDayHigh + " " + res.currency + "</td>\
                            <td>Day Low: "+ res.regularMarketDayLow + " " + res.currency + "</td> \
                            </tr>\
                            <tr>\
                            <td>52 Week High: "+ res.fiftyTwoWeekHigh + " " + res.currency + "</td>\
                            <td>52 Week Low: "+ res.fiftyTwoWeekLow + " " + res.currency + "</td> \
                            </tr>\
                        </table>" ;
                        //res.regularMarketPrice + " CAD";
                    }
                    else{
                        document.getElementById("disp").innerHTML =  "<table class=\"center\">\
                            <tr>\
                            <th colspan=2>" + res.longName + " (" + res.symbol +")</th>\
                            </tr>\
                            <tr>\
                            <th colspan=2>Value: "+ res.regularMarketPrice + " " + res.currency + " (" + res.fullExchangeName + ")</th>\
                            </tr>\
                            <tr>\
                            <td>Post Market Price: "+ postval + "</td>\
                            <td>Exchange: " + state + "</td>\
                            </tr>\
                            <tr>\
                            <td>Open: "+ res.regularMarketOpen + " " + res.currency + "</td>\
                            <td>Previous Close: "+ res.regularMarketPreviousClose + " " + res.currency + "</td> \
                            </tr>\
                            <tr>\
                            <td>Day High: "+ res.regularMarketDayHigh + " " + res.currency + "</td>\
                            <td>Day Low: "+ res.regularMarketDayLow + " " + res.currency + "</td> \
                            </tr>\
                            <tr>\
                            <td>52 Week High: "+ res.fiftyTwoWeekHigh + " " + res.currency + "</td>\
                            <td>52 Week Low: "+ res.fiftyTwoWeekLow + " " + res.currency + "</td> \
                            </tr>\
                        </table>";
                    }
                    
                }

            });
        }
    });
});

console.log("Sohaib Wasif")