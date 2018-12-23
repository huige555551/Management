package Servlets;

import Classes.DatabaseInit;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UpdateAccidentServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");

        String json;
        PrintWriter out = response.getWriter();

        try {
            String order_number = request.getParameter("order_number");
            String time = request.getParameter("time");
            String place = request.getParameter("place");
            String type = request.getParameter("type");

            Connection conn = DatabaseInit.getConnection();
            String sql = "update car.accident set time= ?, place = ?, type = ? where order_number = ?;";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, time);
            ps.setString(2, place);
            ps.setString(3, type);
            ps.setString(4, order_number);
            ps.executeUpdate();
        } catch (Exception e) {
            json = "{\"code\": \"1\"}";
            out.println(JSONObject.fromObject(json));
            out.close();
            e.printStackTrace();
        }

        json = "{\"code\": \"0\"}";
        out.println(JSONObject.fromObject(json));
        out.close();
    }
}
