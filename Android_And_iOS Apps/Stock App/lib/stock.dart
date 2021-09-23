import 'package:http/http.dart' as http;
import 'dart:convert';

class Stock {
  final String symbol;
  final String market;
  final String open;
  final String close;
  final String high;
  final String low;
  final String value;
  final String ftweekH;
  final String ftweekL;
  final String cap;
  final String volume;
  final String hint;
  final String info;

  Stock(this.symbol, this.market, this.open, this.close, this.high, this.low, this.value, this.ftweekH, this.ftweekL, this.cap, this.volume, this.hint, this.info);

  static Future <Stock?> getStock (String symbol, String market) async {
    String searchSymbol = market == "CDN" ? symbol + ".to" : symbol;

    final url = "https://yahoo-finance15.p.rapidapi.com/api/yahoo/qu/quote/${searchSymbol}?rapidapi-key=e9aaab42f7msh7a1ebf291f1c262p108dcbjsnf45b92f2264c";
    final url2 = "https://yahoo-finance15.p.rapidapi.com/api/yahoo/qu/quote/${searchSymbol}/asset-profile?rapidapi-key=e9aaab42f7msh7a1ebf291f1c262p108dcbjsnf45b92f2264c";

    final res = await http.get(Uri.parse(url));
    var data1 = json.decode(res.body)[0];
    if (data1["shortName"] == null) {
      return null;
    }

    final res2 = await http.get(Uri.parse(url2));
    var data2 = json.decode(res2.body);

    //var data1 = testData1;
    //var data2 = testData2;

    return Stock(
        data1["symbol"].toString(),
        market,
        data1["regularMarketOpen"].toString(),
        data1["regularMarketPreviousClose"].toString(),
        data1["regularMarketDayHigh"].toString(),
        data1["regularMarketDayLow"].toString(),
        data1["regularMarketPrice"].toString(),
        data1["fiftyTwoWeekHigh"].toString(),
        data1["fiftyTwoWeekLow"].toString(),
        data1["marketCap"].toString(),
        data1["regularMarketVolume"].toString(),
        data1["priceHint"].toString(),
        data2["assetProfile"]!["longBusinessSummary"].toString()
    );
  }

  static final testData1 = {
    "ask": 134.35,
    "askSize": 18,
    "averageDailyVolume10Day": 89822366,
    "averageDailyVolume3Month": 107040886,
    "bid": 134.32,
    "bidSize": 22,
    "bookValue": 3.936,
    "currency": "USD",
    "dividendDate": {
      "date": "2021-02-11 00:00:00.000000",
      "timezone_type": 1,
      "timezone": "+00:00"
    },
    "earningsTimestamp": {
      "date": "2021-04-28 20:00:00.000000",
      "timezone_type": 1,
      "timezone": "+00:00"
    },
    "earningsTimestampStart": {
      "date": "2021-04-28 20:00:00.000000",
      "timezone_type": 1,
      "timezone": "+00:00"
    },
    "earningsTimestampEnd": {
      "date": "2021-04-28 20:00:00.000000",
      "timezone_type": 1,
      "timezone": "+00:00"
    },
    "epsForward": 4.7,
    "epsTrailingTwelveMonths": 3.687,
    "exchange": "NMS",
    "exchangeDataDelayedBy": 0,
    "exchangeTimezoneName": "America/New_York",
    "exchangeTimezoneShortName": "EDT",
    "fiftyDayAverage": 123.43172,
    "fiftyDayAverageChange": 10.998276,
    "fiftyDayAverageChangePercent": 0.08910413,
    "fiftyTwoWeekHigh": 145.09,
    "fiftyTwoWeekHighChange": -10.660004,
    "fiftyTwoWeekHighChangePercent": -0.073471665,
    "fiftyTwoWeekLow": 66.3575,
    "fiftyTwoWeekLowChange": 68.072495,
    "fiftyTwoWeekLowChangePercent": 1.0258448,
    "financialCurrency": "USD",
    "forwardPE": 28.602127,
    "fullExchangeName": "NasdaqGS",
    "gmtOffSetMilliseconds": -14400000,
    "language": "en-US",
    "longName": "Apple Inc.",
    "market": "us_market",
    "marketCap": 2256824172544,
    "marketState": "POST",
    "messageBoardId": "finmb_24937",
    "postMarketChange": -0.17999268,
    "postMarketChangePercent": -0.13389324,
    "postMarketPrice": 134.25,
    "postMarketTime": {
      "date": "2021-04-13 22:48:18.000000",
      "timezone_type": 1,
      "timezone": "+00:00"
    },
    "priceHint": 2,
    "priceToBook": 34.15396,
    "quoteSourceName": "Nasdaq Real Time Price",
    "quoteType": "EQUITY",
    "regularMarketChange": 3.1899872,
    "regularMarketChangePercent": 2.4306514,
    "regularMarketDayHigh": 134.66,
    "regularMarketDayLow": 131.94,
    "regularMarketOpen": 132.44,
    "regularMarketPreviousClose": 131.24,
    "regularMarketPrice": 134.43,
    "regularMarketTime": {
      "date": "2021-04-13 20:00:02.000000",
      "timezone_type": 1,
      "timezone": "+00:00"
    },
    "regularMarketVolume": 87964051,
    "sharesOutstanding": 16788100096,
    "shortName": "Apple Inc.",
    "sourceInterval": 15,
    "symbol": "AAPL",
    "tradeable": false,
    "trailingAnnualDividendRate": 0.807,
    "trailingAnnualDividendYield": 0.0061490396,
    "trailingPE": 36.460533,
    "twoHundredDayAverage": 124.13669,
    "twoHundredDayAverageChange": 10.293304,
    "twoHundredDayAverageChangePercent": 0.08291911
  };

  static final testData2 = {
    "assetProfile": {
      "address1": "One Apple Park Way",
      "city": "Cupertino",
      "state": "CA",
      "zip": "95014",
      "country": "United States",
      "phone": "408-996-1010",
      "website": "http://www.apple.com",
      "industry": "Consumer Electronics",
      "sector": "Technology",
      "longBusinessSummary": "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. It also sells various related services. The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, HomePod, iPod touch, and other Apple-branded and third-party accessories. It also provides AppleCare support services; cloud services store services; and operates various platforms, including the App Store, that allow customers to discover and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers various services, such as Apple Arcade, a game subscription service; Apple Music, which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses; and the education, enterprise, and government markets. It sells and delivers third-party applications for its products through the App Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. Apple Inc. was founded in 1977 and is headquartered in Cupertino, California.",
      "fullTimeEmployees": 147000,
      "companyOfficers": [
        {
          "maxAge": 1,
          "name": "Mr. Timothy D. Cook",
          "age": 59,
          "title": "CEO & Director",
          "yearBorn": 1961,
          "fiscalYear": 2020,
          "totalPay": {
            "raw": 14769259,
            "fmt": "14.77M",
            "longFmt": "14,769,259"
          },
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Mr. Luca  Maestri",
          "age": 56,
          "title": "CFO & Sr. VP",
          "yearBorn": 1964,
          "fiscalYear": 2020,
          "totalPay": {
            "raw": 4595583,
            "fmt": "4.6M",
            "longFmt": "4,595,583"
          },
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Mr. Jeffrey E. Williams",
          "age": 56,
          "title": "Chief Operating Officer",
          "yearBorn": 1964,
          "fiscalYear": 2020,
          "totalPay": {
            "raw": 4594137,
            "fmt": "4.59M",
            "longFmt": "4,594,137"
          },
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Ms. Katherine L. Adams",
          "age": 56,
          "title": "Sr. VP, Gen. Counsel & Sec.",
          "yearBorn": 1964,
          "fiscalYear": 2020,
          "totalPay": {
            "raw": 4591310,
            "fmt": "4.59M",
            "longFmt": "4,591,310"
          },
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Ms. Deirdre  O'Brien",
          "age": 53,
          "title": "Sr. VP of People & Retail",
          "yearBorn": 1967,
          "fiscalYear": 2020,
          "totalPay": {
            "raw": 4614684,
            "fmt": "4.61M",
            "longFmt": "4,614,684"
          },
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Mr. Chris  Kondo",
          "title": "Sr. Director of Corp. Accounting",
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Mr. James  Wilson",
          "title": "Chief Technology Officer",
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Ms. Mary  Demby",
          "title": "Chief Information Officer",
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Ms. Nancy  Paxton",
          "title": "Sr. Director of Investor Relations & Treasury",
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        },
        {
          "maxAge": 1,
          "name": "Mr. Greg  Joswiak",
          "title": "Sr. VP of Worldwide Marketing",
          "exercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          },
          "unexercisedValue": {
            "raw": 0,
            "fmt": null,
            "longFmt": "0"
          }
        }
      ],
      "auditRisk": 6,
      "boardRisk": 1,
      "compensationRisk": 2,
      "shareHolderRightsRisk": 1,
      "overallRisk": 1,
      "governanceEpochDate": 1617235200,
      "compensationAsOfEpochDate": 1609372800,
      "maxAge": 86400
    }
  };
}