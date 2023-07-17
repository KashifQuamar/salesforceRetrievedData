public class checkString {
public static String substringBetween(String input, String startDelimiter, String endDelimiter) {
        Integer startIndex = input.indexOf(startDelimiter);
        
        if (startIndex != -1) {
            startIndex += startDelimiter.length();
            Integer endIndex = input.indexOf(endDelimiter, startIndex);
            
            if (endIndex != -1) {
                return input.substring(startIndex, endIndex);
            }
        }
        
        return null;
    }
    
    public static void performSubstringBetween() {
         String input = '<a href="https://rubrik.atlassian.net/browse/CDM-292882" target="_blank">CDM-292882</a>';
        String startDelimiter = '>';
        String endDelimiter = ' </a>';
        
        String result = substringBetween(input, startDelimiter, endDelimiter);
        System.debug('Substring between delimiters: ' + result);
    }


}