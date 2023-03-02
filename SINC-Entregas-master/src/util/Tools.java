package util;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.pojo.Carga;

/**
 *
 * @author Andressa
 */
public class Tools {
    
    public static String stringsCodigosParaQueryIN(List<Carga> cargaList){
        //in (3403, 2868, 3159, 4111)
    String queryInicio = "(";
    String queryFim = ")";
    String queryLoop = "";
    
    for(Carga carga : cargaList){
       queryLoop = queryLoop+carga.getCargaId()+",";
    }
    queryLoop = queryLoop.substring(0, queryLoop.length() - 1);
    return queryInicio+queryLoop+queryFim;
    }
    public static String getExceptionStackTrace(Exception e){
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        String exceptionAsString = sw.toString();
        return exceptionAsString;
    }
    
    //2016-08-24 09:46:03.064
    public static Timestamp getTodayTimestamp() {
        return Timestamp.valueOf(LocalDateTime.now());
    }

    //2016-08-24
    public static java.sql.Date getTodaySQLDate() {
        return new java.sql.Date(Calendar.getInstance().getTimeInMillis());
    }

    public static String formatDate(Date date) {
        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
        return (date != null) ? fmt.format(date) : "";
    }

    public static LocalDate parseStringToDate(String date) {
        DateTimeFormatter formato = DateTimeFormatter.
                ofPattern("dd/MM/yyyy");
        return (!date.isEmpty()) ? LocalDate.parse(date, formato) : null;
    }
    
    public static String padronizaFormatoData(String dateString){
        String retorno = "";
        try {
            SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            Date date = format1.parse(dateString);
            retorno = (format2.format(date));
            
            return retorno;
        } catch (ParseException ex) {
            Logger.getLogger(Tools.class.getName()).log(Level.SEVERE, null, ex);
        }
        return retorno;
    }

    //dia/mes/ano
    public static java.sql.Date parseStringToSQLDate(String data) {
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // New Pattern
        java.util.Date date = null;
        try {
            date = sdf1.parse(data);
        } catch (ParseException ex) {
            ex.printStackTrace();
            Logger.getLogger(Tools.class.getName()).log(Level.SEVERE, null, ex);
        }
        java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
        return sqlStartDate;
    }
    
    public static java.sql.Date getActualDateToSQL() {
        Date actualDate = new Date();
        Date date = null;
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        
        try {
            date = sdf1.parse(sdf1.format(actualDate));
            System.err.println("date: "+date);
            System.err.println("actualDate: "+actualDate);
        } catch (ParseException ex) {
            ex.printStackTrace();
            Logger.getLogger(Tools.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new java.sql.Date(date.getTime());
    }
}
