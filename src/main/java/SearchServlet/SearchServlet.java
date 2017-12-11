package SearchServlet;

import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

/**
 * @author: zhangocean
 * @Date: Created in 20:40 2017/12/9
 * Describe:
 */
public class SearchServlet extends HttpServlet {

    static List<String> datas = new ArrayList<String>();
    static {

        datas.add("ajax1");
        datas.add("ajax post");
        datas.add("becky");
        datas.add("bill");
        datas.add("james");
        datas.add("jerry");
        datas.add("张海洋");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        //首先获得客户端发送来的数据keyword
        String keyword = req.getParameter("keyword");
        //String keyword = URLDecoder.decode(keyword1,"utf-8");
        //获得关键字之后进行处理，得到关联数据
        List<String> listData = getData(keyword);
        //返回Json格式
        //System.out.println(JSONArray.fromObject(listData));
        resp.getWriter().write(JSONArray.fromObject(listData).toString());
    }

    //获得关联数据的方法
    public List<String> getData(String keyword) {

        List<String> list = new ArrayList<String>();

        for(String data : datas) {
            if(data.contains(keyword) && keyword != "") {
                list.add(data);
            }

        }
        return list;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
