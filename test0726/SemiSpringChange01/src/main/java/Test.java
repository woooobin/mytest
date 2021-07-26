import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.spring.poosil.bookdto.BookDto;

public class Test {
	
	public static void main(String[] args) throws IOException, XmlPullParserException {
		  String clientID="Ra01NPO8MNcsr03Awa5F";
	        String clientSecret = "WfBy_BK8WK";
	        URL url = new URL("https://openapi.naver.com/v1/search/book.json");
	        
	        URLConnection urlConn=url.openConnection(); //openConnection 해당 요청에 대해서 쓸 수 있는 connection 객체 
	        
	        urlConn.setRequestProperty("X-Naver-Client-ID", clientID);
	        urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
	        
	        String data="";
	        String msg = null;
	        while((msg = br.readLine())!=null)
	        {
//	            System.out.println(msg);
	            data += msg;
	        }
	        
	        List<BookDto> list = null; //결과데이터 담을 리스트 
//	        System.out.println(data); //응답받은 xml문서 xml문서로부터 내가 원하는 값 탐색하기(xml 파싱)
	         XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
	         XmlPullParser parser = factory.newPullParser(); //연결하는거 담고 
	         parser.setInput(new StringReader(data));
	         int eventType= parser.getEventType();
	         BookDto b = null;
	         while(eventType != XmlPullParser.END_DOCUMENT){
	             switch(eventType){
	             case XmlPullParser.END_DOCUMENT://문서의 끝 
	                 break;
	             case XmlPullParser.START_DOCUMENT:
	                 list = new ArrayList<BookDto>();
	                 break;
	             case XmlPullParser.END_TAG:{
	                 String tag = parser.getName();
	                 if(tag.equals("item")){
	                     list.add(b);
	                     b = null;
	                 }
	             }
	                 
	                 
	             case XmlPullParser.START_TAG:{ //무조건 시작하면 만남 
	                 String tag = parser.getName();
	                 switch(tag){
	                 case "item": //item가 열렸다는것은 새로운 책이 나온다는것 
	                     b = new BookDto();
	                     break;
	                 case "title":
	                     if(b!=null)
	                         b.setTitle(parser.nextText());
	                     break;
	                 case "link":
	                     if(b!=null)
	                         b.setLink(parser.nextText());
	                     break;
	                 case "image":
	                     if(b!=null)
	                         b.setImage(parser.nextText());
	                     break;
	                 case "author":
	                     if(b!=null)
	                         b.setAuthor(parser.nextText());
	                     break;
	                 case "price":
	                     if(b!=null)
	                         b.setPrice(parser.nextText());
	                     break;
	                 case "discount":
	                     if(b!=null)
	                         b.setDiscount(parser.nextText());
	                     break;
	                 case "pubdate":
	                     if(b!=null)
	                         b.setPubdate(parser.nextText());
	                     break;
	                 case "isbn":
	                     if(b!=null)
	                         b.setIsbn(parser.nextText());
	                     break;
	                 case "description":
	                     if(b!=null)
	                         b.setDescription(parser.nextText());
	                     break;
	                 }
	                 break;
	             }
	         }
	             eventType =parser.next();
	    
	    }
	    for(BookDto book:list)
	        System.out.println(book);
	    }
	}




