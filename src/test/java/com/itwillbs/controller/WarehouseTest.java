/*
 * package com.itwillbs.controller;
 * 
 * import java.sql.Connection;
 * 
 * import javax.inject.Inject;
 * 
 * import org.apache.ibatis.session.SqlSession; import org.junit.Test; import
 * org.junit.runner.RunWith; import org.slf4j.Logger; import
 * org.slf4j.LoggerFactory; import
 * org.springframework.test.context.ContextConfiguration; import
 * org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
 * 
 * import com.eatit.warehouseDomain.WarehouseVO; import
 * com.eatit.warehousePersistence.WarehouseDAO;
 * 
 * @RunWith(SpringJUnit4ClassRunner.class)
 * 
 * @ContextConfiguration(locations =
 * {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}) public class
 * WarehouseTest {
 * 
 * 
 * private static final Logger logger =
 * LoggerFactory.getLogger(WarehouseTest.class);
 * 
 * private static final String NAMESPACE = "com.eatit.mapper.warehouseMapper.";
 * 
 * @Inject private WarehouseDAO wdao;
 * 
 * @Inject private SqlSession sqlsession;
 * 
 * 
 * // @Test public void warehouseTest() { WarehouseVO vo = new WarehouseVO();
 * vo.setAdmin_no(3); vo.setLocation_name("李쎄퀬 1�룞");
 * vo.setWarehouse_name("�옄�옱2李쎄퀬"); vo.setCategory("�옄�옱");
 * vo.setNote("�뀒�뒪�듃李쎄퀬�엯�땲�떎!"); wdao.insertWarehouse(vo); }
 * 
 * 
 * // @Test public void 李쎄퀬�궘�젣�뀒�뒪�듃() { WarehouseVO vo = new WarehouseVO();
 * vo.setWarehouse_no(50);
 * 
 * // wdao.deleteWarehouse(vo); }
 * 
 * @Test public void 吏곸콉�젙蹂댄뀒�뒪�듃() { // wdao.getPositionName();
 * wdao.getMembersOfPosition("誘몄젙"); }
 * 
 * }
 */