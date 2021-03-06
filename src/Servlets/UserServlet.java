package Servlets;

import Classes.DatabaseInit;
import Classes.User;
import net.sf.json.JSONArray;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class UserServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");

        ArrayList<User> list = new ArrayList<>();
        try {
            Connection conn = DatabaseInit.getConnection();
            String sql = "select * from car.user order by user_phone;";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);

            getList(list, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        JSONArray json = JSONArray.fromObject(list);

        PrintWriter out = response.getWriter();
        out.println(json);
        out.close();
    }

    static void getList(ArrayList<User> list, ResultSet rs) throws SQLException {
        while(rs.next())
        {
            User u = new User();
            u.setUser_phone(rs.getString("user_phone"));
            u.setUser_name(rs.getString("user_name"));
            u.setUser_pwd(rs.getString("user_pwd"));
            u.setId(rs.getString("id"));
//            u.setState(rs.getInt("state"));
            u.setBalance(rs.getInt("balance"));
            u.setDeposit(rs.getInt("deposit"));
            u.setScore(rs.getInt("score"));
            list.add(u);
        }
    }
}
