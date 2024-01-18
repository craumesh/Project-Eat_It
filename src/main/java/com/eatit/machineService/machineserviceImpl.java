package com.eatit.machineService;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Future;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eatit.machineDomain.machineVO;
import com.eatit.machineDomain.machinehistoryVO;
import com.eatit.machinePersistence.machineDAO;
import com.eatit.mainDomain.Criteria;

@Service
public class machineserviceImpl implements machineservice {

    private static final Logger logger = LoggerFactory.getLogger(machineserviceImpl.class);

    @Inject
    private machineDAO mcdao;

    @Override
    public void insertmachine(machineVO vo) {
        logger.debug("DAO 설비 추가 메서드 호출 - 시작");
        mcdao.insertmachine(vo);
        logger.debug("DAO 설비 추가 메서드 호출 - 끝");
    }

    @Override
    public List<machineVO> machinelist(Criteria cri) {
        logger.debug("machinelist()");
        return mcdao.getmachinelist(cri);
    }

    @Override
    public void machinehistory(machinehistoryVO vo) {
        logger.debug("machinehistory(machinehistoryVO vo)");
        mcdao.machinehistory(vo);
        logger.debug("machinehistory vo : " + vo);
    }

    @Override
    public int getmachinecode() {
        logger.debug("getmachinecode() 호출");
        return mcdao.getmachinecode();
    }

    @Override
    public machineVO machineinfo(int code) {
        logger.debug("machineinfo() 호출");
        return mcdao.machineinfo(code);
    }

    @Override
    public int machineupdate(machineVO vo) {
        logger.debug("machineupdate() 호출");
        return mcdao.machineupdate(vo);
    }

    @Override
    public void machinedelete(machineVO vo) {
        logger.debug("machinedelete() 호출");
        mcdao.machinedelete(vo);
    }

    @Override
    public int totalCount() {
        logger.debug("totalCount() 호출");
        return mcdao.totalCount();
    }

	@Override
	public void machinedeleteupdate(machineVO vo) {
		logger.debug("machinedeleteupdate() 호출");
		mcdao.machinedeleteupdate(vo);
		
	}

	@Override
	public machineVO productstatus(int code) {
		logger.debug("productstatus() 호출");
		return mcdao.productstatus(code);
	}

	@Override
	public List<machineVO> machinecategory() {
		logger.debug("Service : machinecategory()");
		return mcdao.machinecategory();
	}

    
    
}
	


