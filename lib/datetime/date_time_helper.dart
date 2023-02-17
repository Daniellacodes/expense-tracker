// convert datetime object to a string that is just the yyyymmdd
String convertDateTimeToString(DateTime dateTime)
{
  // year in yyyy format
  String year = dateTime.year.toString();

  // month in mmm format
  String month = dateTime.month.toString();
  if (month.length == 1)
  {
    month = '0'+ month;
  }

  // day in dd format
  String day = dateTime.day.toString();
   if (day.length == 1)
  {
    month = '0'+ day; 
  }

  // final year format
  String yyyymmdd = year + month + day;

  return yyyymmdd;



}

/*
Date
 */