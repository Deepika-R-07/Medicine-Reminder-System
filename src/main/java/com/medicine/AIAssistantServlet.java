package com.medicine;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AIAssistantServlet")
public class AIAssistantServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Paste your Groq API key here
    private static final String API_KEY = System.getenv("GROQ_API_KEY");
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String question = request.getParameter("question");

        if (question == null || question.trim().isEmpty()) {
            request.setAttribute("answer", "Please enter your question.");
            request.getRequestDispatcher("aiAssistant.jsp").forward(request, response);
            return;
        }

        String answer = getGroqResponse(question);

        request.setAttribute("answer", answer);
        request.getRequestDispatcher("aiAssistant.jsp").forward(request, response);
    }

    private String getGroqResponse(String question) {

        try {

            String apiURL = "https://api.groq.com/openai/v1/chat/completions";

            URL url = new URL(apiURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
            conn.setDoOutput(true);

            String prompt =
                    "You are a helpful AI medical assistant. " +
                    "Provide short, simple and safe answers. " +
                    "Do not diagnose diseases. " +
                    "Always recommend consulting a doctor for serious symptoms.";

           
         // Escape special characters
            String safePrompt = prompt
                    .replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\r", "\\r")
                    .replace("\n", "\\n");

            String safeQuestion = question
                    .replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\r", "\\r")
                    .replace("\n", "\\n");

            String body =
                    "{"
                    + "\"model\":\"llama-3.3-70b-versatile\","
                    + "\"messages\":["
                    + "{"
                    + "\"role\":\"system\","
                    + "\"content\":\"" + safePrompt + "\""
                    + "},"
                    + "{"
                    + "\"role\":\"user\","
                    + "\"content\":\"" + safeQuestion + "\""
                    + "}"
                    + "]"
                    + "}";
            OutputStream os = conn.getOutputStream();
            os.write(body.getBytes("UTF-8"));
            os.flush();
            os.close();

            BufferedReader br;

            if (conn.getResponseCode() == 200) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            StringBuilder sb = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            br.close();

            System.out.println("HTTP Code: " + conn.getResponseCode());
            System.out.println(sb.toString());

            JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();

            if (json.has("error")) {
                return "Groq Error: " +
                        json.getAsJsonObject("error")
                            .get("message")
                            .getAsString();
            }

            JsonArray choices = json.getAsJsonArray("choices");

            if (choices != null && choices.size() > 0) {

                JsonObject message = choices.get(0)
                        .getAsJsonObject()
                        .getAsJsonObject("message");

                return message.get("content").getAsString();
            }

            return "No response received from AI.";

        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
    }
}