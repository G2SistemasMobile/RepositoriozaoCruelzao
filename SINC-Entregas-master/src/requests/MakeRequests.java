package requests;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import util.Log;

public class MakeRequests {
    static String output = "", retorno = "";
    static private Log lgErro;

    public MakeRequests() {

    }
        public static String makeGetRequest(String endpoint) throws IOException, InterruptedException {
        URL url = new URL(endpoint);
        StringBuilder content = new StringBuilder();
        int status;
        HttpURLConnection con;
        con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        System.err.println("url: "+url);

        con.setRequestProperty("accept", "application/json;charset=UTF-8");
        con.setRequestProperty("Content-Type", "application/json");

        status = con.getResponseCode();
        System.err.println("[STATUS/makeGetRequest]: "+status);
        
        if(status >= 300){
            try (Scanner s = new Scanner(new InputStreamReader(con.getErrorStream())).useDelimiter("\\A")) {
                String result = s.hasNext() ? s.next() : "";
                content.append("Erro: ").append(status).append(" -> ").append(result).append("\nStatus: ").append(status);
            }
            util.Log.ocorreuUmErroLog("makeGetRequest", "[ATENÇÃO]: BAD REQUEST:\n"
                    + "\n"+"[STATUS/REQUISIÇÃO]: "+status
                            + "\n[ERRO:] " + content.toString() + "\n"+"URL: "+url, lgErro);
        }
        else if (status <= 299) {
                try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                }
            }
        }
        con.disconnect();
        return content.toString();
    }
        
    public static String makePostRequest(String url, String jsonArgStr) throws IOException{
        StringBuilder response = new StringBuilder();
        String inputLine;
        HttpURLConnection urlCon;
        String respostaPost = "";
        try {
                URL obj = new URL(url);
                urlCon = (HttpURLConnection) obj.openConnection();
                urlCon.setRequestMethod("POST");
                urlCon.setRequestProperty("accept", "application/json;charset=UTF-8");
                urlCon.setRequestProperty("Content-type", "application/json");
                urlCon.setDoOutput(true);

                try (OutputStreamWriter wr = new OutputStreamWriter(urlCon.getOutputStream(), "UTF-8")) {
                    wr.write(jsonArgStr);
                    wr.flush();
                }
                urlCon.connect();
                int responseCode = urlCon.getResponseCode();
                BufferedReader in;
                if (responseCode >= 200 && responseCode < 300){
                    in = new BufferedReader(
                        new InputStreamReader(urlCon.getInputStream()));
                }else{
                    in = new BufferedReader(
                        new InputStreamReader(urlCon.getErrorStream()));
                }
                while ((inputLine = in.readLine()) != null) {response.append(inputLine);}
                respostaPost = response.toString();
                in.close();
            } catch (Exception ex){
                util.Log.ocorreuUmErroLog("makePostRequest", ex, lgErro);
            }
        return respostaPost;
    }
}