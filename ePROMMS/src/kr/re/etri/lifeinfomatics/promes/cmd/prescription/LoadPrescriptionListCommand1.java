package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.sun.media.sound.InvalidFormatException;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;

public class LoadPrescriptionListCommand1 implements Command {

	public LoadPrescriptionListCommand1(String string) {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String execute(HttpServletRequest req) throws CommandException {
		try {
			Document doc = Jsoup.connect("http://torrentgun.net/bbs/cache.php?k=140504").get();
			Elements tds = doc.select("#blist");
			
			String result = tds.toString();
			

//			HttpClient httpClient = new DefaultHttpClient();
//		    HttpGet httpget = new HttpGet("http://kbodata.news.naver.com/m_rank/rank_team.asp");
//		    try {
//		      httpClient.execute(httpget, new BasicResponseHandler() {
//		        @Override
//		        public String handleResponse(HttpResponse response) throws HttpResponseException,
//		            IOException {
//		          // 웹페이지를 그냥 갖어오면 한글이 깨져요. 인코딩 처리를 해야해요.
//		          String res = new String(super.handleResponse(response).getBytes("8859_1"), "euc-kr");
//		          Document doc = Jsoup.parse(res);
//		          Elements rows = doc.select("table.table_board2 tbody tr");
//		          String[] items = new String[] { "순위", "팀", "경기수", "승", "패", "무", "승률", "연속",
//		              "최근 10경기" };
//		          for (Element row : rows) {
//		            Iterator<Element> iterElem = row.getElementsByTag("td").iterator();
//		            StringBuilder builder = new StringBuilder();
//		            for (String item : items) {
//		              builder.append(item + ": " + iterElem.next().text() + "   \t");
//		            }
//		            System.out.println(builder.toString());
//		          }
//		 
//		          return res;
//		        }
//		      });
//		    } catch (ClientProtocolException e) {
//		      e.printStackTrace();
//		    } catch (IOException e) {
//		      e.printStackTrace();
//		    }
			
//			String sortType = req.getParameter("sortType");
//			String sortName = req.getParameter("sortName");
//			String page = req.getParameter("page");
//			String offset = "10"; //한 페이지에 보여줄 수
//			if(sortType=="" || sortType ==null)
//				sortType = "asc";
//			if(sortName=="" || sortName ==null)
//				sortName = "org";
//			if(page=="" || page == null)
//				page="1";
//			String startPoint = String.valueOf((Integer.parseInt(page) - 1) * Integer.parseInt(offset));
//			String prescriptionListTotalCnt =  PrescriptionManager.getInstance().getPrescriptionListTotalCnt(null, null, null, null, null, null, null, null, "admin", null, null,sortName,sortType);
//			ArrayList<PrescriptionInfo> prescriptionList =  PrescriptionManager.getInstance().getPrescriptionListNew(null, null, null, null, null, null, null, null, "admin", null, null,sortName, sortType,startPoint, offset);
//			
//			String pageTotalCnt = String.valueOf( Integer.parseInt(prescriptionListTotalCnt) / Integer.parseInt(offset) );
//			if(Integer.parseInt(prescriptionListTotalCnt) % Integer.parseInt(offset) != 0)
//				pageTotalCnt = String.valueOf(Integer.parseInt(pageTotalCnt)+1);
//			
//			req.setAttribute("prescriptionList", prescriptionList);
//			req.setAttribute("sortName", sortName);
//			req.setAttribute("sortType", sortType);
//			req.setAttribute("pageTotalCnt", pageTotalCnt);
//			req.setAttribute("page", page);
			req.setAttribute("result", result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "_index.jsp";
		//return "home/prescription/NewPrescriptionList.jsp";
	}

}
