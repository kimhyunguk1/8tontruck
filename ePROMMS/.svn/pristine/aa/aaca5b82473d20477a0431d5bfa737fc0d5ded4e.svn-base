package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.io.BufferedReader;
import java.io.DataOutputStream;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;



import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;

import kr.re.etri.lifeinfomatics.promes.util.Log;


public class LoadTBFREE_FileSend implements Command{

	public LoadTBFREE_FileSend(String string) {
		// TODO Auto-generated constructor stub
	}
	
	public String execute(HttpServletRequest req) throws CommandException{
		try{			
			String url = "https://112.216.188.42:8443/TBFREE/m/medi_mg/take_wr.do?LANGUAGE_CODE=KOR" + "&USER_NO=";
			//String url = "http://localhost:8080/m/medi_mg/take_wr_ddot.do?dot_rpt_no?taken_dt=20130101&taken_ti=0000";			             
			System.out.println( "Send file...." );
			System.out.println( url );
			String lineEnd = "\r\n";
			String twoHyphens = "--";
			String boundary = "*****";
			String fileName = "C:\\test2.mp4";
			
			FileInputStream mFileInputStream = new FileInputStream( fileName );			
			HttpsURLConnection conn = null;
			HttpURLConnection connHTTP = null;
			
			URL connectUrl = new URL( url );			
			
			if( connectUrl.getProtocol().toLowerCase().equals( "https" ) ) {
				VariableHandler.trustAllHosts();
				
				try {
					HttpsURLConnection https = (HttpsURLConnection)connectUrl.openConnection();
					https.setHostnameVerifier( VariableHandler.DO_NOT_VERIFY );
					conn = https;
				} catch ( IOException e ) {
					e.printStackTrace();
				}
			} else {
				try {
					//connHTTP = (HttpURLConnection) connectUrl.openConnection();
					conn = (HttpsURLConnection)connectUrl.openConnection();
				} catch ( IOException e ) {
					e.printStackTrace();
				}
			}
			
			// open connection 			
			conn.setDoInput( true );
			conn.setDoOutput( true );
			conn.setUseCaches( false );
			conn.setRequestMethod( "POST" );
			conn.setConnectTimeout( 35000 );
			conn.setRequestProperty( "Connection", "Keep-Alive" );
			conn.setRequestProperty( "Content-Type", "multipart/form-data;boundary=" + boundary );
            
			// write data
			DataOutputStream dos = new DataOutputStream( conn.getOutputStream() );
			dos.writeBytes( twoHyphens + boundary + lineEnd );
			dos.writeBytes( "Content-Disposition: form-data; name=\"USER_FILE\";filename=\"" + fileName + "\"" + lineEnd );
			dos.writeBytes( lineEnd );
			
			int bytesAvailable = mFileInputStream.available();
			int maxBufferSize = 1024;
			int bufferSize = Math.min( bytesAvailable, maxBufferSize );
			
			byte[] buffer = new byte[bufferSize];
			int bytesRead = mFileInputStream.read( buffer, 0, bufferSize );
			
			// read image
			while ( bytesRead > 0 ) {
				dos.write( buffer, 0, bufferSize );
				bytesAvailable = mFileInputStream.available();
				bufferSize = Math.min( bytesAvailable, maxBufferSize );
				bytesRead = mFileInputStream.read( buffer, 0, bufferSize );
			}	
			
			dos.writeBytes( lineEnd );
			dos.writeBytes( twoHyphens + boundary + twoHyphens + lineEnd );
			
			// close streams
			mFileInputStream.close();
			dos.flush(); // finish upload..
			
			// get response
			InputStream is = conn.getInputStream();
			BufferedReader br = new BufferedReader( new InputStreamReader( is ) );
			
			while( br.read() > 0 ) {
				System.out.println( "Message : " + br.readLine() );
			}
			dos.close();
			
			return "";
		}catch(Exception ex){
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
		
	}
}
