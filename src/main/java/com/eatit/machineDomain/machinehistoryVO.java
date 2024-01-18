package com.eatit.machineDomain;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;



import lombok.Data;

@Data
public class machinehistoryVO {
	
	private int history_no;
	private int machine_code;
	private Timestamp operating_time;
	private String use_history;
	private String check_purpose;
	private Date check_time;
	private int employee_no;
	private String machine_update;
	private Timestamp machine_update_date;
	private Timestamp timeto_c;
	private int product_time;

	
}
	