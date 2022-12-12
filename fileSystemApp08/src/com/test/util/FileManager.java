/*======================
   FileManager.java
======================== */

package com.test.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;

public class FileManager
{
	//파일 다운로드 메소드 정의
	// - savaFileName : 서버에 저장된 피일 이름
	// - originalFileName : 클라이언트가 업로드한 파일 이름
	// - path : 서버에 저장된 경로
	// - response : HTTP 프로토콜을 기반으로 요청에 응답하는 객체
	public static boolean doFileDownload(String saveFileName, String originalFileName, String path, HttpServletResponse response)
	{
		// 파일 이름 포함된 경로 구성	(구분자)
		String loadDir = path + File.separator + saveFileName;
		
		// 확인(테스트)
		System.out.println(loadDir);
		
		try
		{
			if (originalFileName == null || originalFileName.equals(""))    
			{
				originalFileName = saveFileName;
			}
			originalFileName = new String(originalFileName.getBytes("EUC-KR"), "8859_1");
			//											String 생성자?
			
		} catch (UnsupportedEncodingException e) 
		{
			System.out.println(e.toString());
		}
		
	
		try
		{
			File file = new File(loadDir);
			
			if (file.exists())
			{
				byte[] readByte = new byte[4096];
				
				// 2줄은 고정값 이거 다 바이너리 기반이라서 해주는것 
				response.setContentType("application/octet-stream");
				response.setHeader("Content-disposition", "attachment;filename=" + originalFileName);
				
				// 읽어온것
				BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file));
				
				// 내보내고
				OutputStream os = response.getOutputStream();
				
				int read;
				while ( (read=fis.read(readByte, 0, 4096)) != -1 )
				{
					os.write(readByte, 0, read);
				}
				
				os.flush();
				os.close();
				fis.close();
				
				return true;
						
						
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return false;
		
		
	}// doFileDownload
	

	// 실제 파일 삭제(제거) 메소드 정의
	// - fileName : 파일 이름
	// - path : 경로
	public static void doFileDelete(String fileName, String path)
	{
		try
		{
			File file = null;
			String fullFileName = path + File.separator + fileName;
			file = new File(fullFileName);
			
			if (file.exists())
			{	
				file.delete();
			}
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
	}
}




