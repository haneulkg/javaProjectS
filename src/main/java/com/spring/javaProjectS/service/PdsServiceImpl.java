package com.spring.javaProjectS.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS.dao.PdsDAO;
import com.spring.javaProjectS.vo.PdsVO;

@Service
public class PdsServiceImpl implements PdsService {

	@Autowired
	PdsDAO pdsDAO;

	@Override
	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part) {
		return pdsDAO.getPdsList(startIndexNo,pageSize,part);
	}

	@Override
	public int setPdsInput(PdsVO vo, MultipartHttpServletRequest mFile) {
		int res = 0;
		try {
			List<MultipartFile> fileList = mFile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
				
				writeFile(file, sFileName);
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize(); // getSize() :  개별 파일의 사이즈 읽어오는 객체
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setFSize(fileSizes);
			
			res = pdsDAO.setPdsInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		byte[] bytes = file.getBytes(); 
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		fos.write(bytes);
		fos.close();
	}

	// 서버에 파일 저장 전 파일명 중복배제시키기
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}

	@Override
	public int setPdsDownNumCheck(int idx) {
		return pdsDAO.setPdsDownNumCheck(idx);
	}

	@Override
	public PdsVO getIdxSearch(int idx) {
		return pdsDAO.getIdxSearch(idx);
	}

	@Override
	public int setPdsDelete(PdsVO vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		String[] fSNames = vo.getFSName().split("/");
		
		// 서버에 저장된 실제 파일 삭제시키기
		for(int i=0; i<fSNames.length; i++) {
			new File(realPath + fSNames[i]).delete();
		}
		
		return pdsDAO.setPdsDelete(vo.getIdx());
	}

}