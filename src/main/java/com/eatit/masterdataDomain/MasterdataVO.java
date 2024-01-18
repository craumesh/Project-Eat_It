package com.eatit.masterdataDomain;

import java.sql.Date;

import lombok.Data;

@Data
public class MasterdataVO {
   private int product_no;
   private String code;
   private String product_code;
   private String product_name;
   private String name;
   private String photo_paths;
   private String category;
   private String category_detail;
   private int company_no;
   private String company_name;
   private String unit;
   private String unit_quantity;
   private float price; 
   private String recipe;
   private int quality_no;
   private String product_visual;
   private String taste;
   private String scent;
   private String texture;
   private String measure;
   private int test_no;
   private String test_tool;
   private String test_method;
   private String test_equipment;
   
}
