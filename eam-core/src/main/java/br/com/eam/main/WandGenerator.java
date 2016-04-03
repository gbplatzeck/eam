package br.com.eam.main;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WandGenerator {

	public static void main(String[] args) {
		Map<String, Double> kernel = new HashMap<String, Double>();
		kernel.put("fibra de coração de dragão",20.0);
		kernel.put("pena de fênix",3.0);
		kernel.put("pêlo de cauda de unicórnio",16.0);
		kernel.put("cabelo de veela",8.0);
		kernel.put("pêlo de cauda de testrálio",7.0);
		kernel.put("coral",12.0);
		kernel.put("pó de chifre de unicórnio",19.0);
		kernel.put("escama de sereiano",16.0);
		kernel.put("pena de hipogrifo",18.0);
		kernel.put("pó de presa de dragão",14.0);
		kernel.put("escama de dragão",20.0);
		kernel.put("pó de chifre de dragão",20.0);
		kernel.put("sangue de unicórnio",4.0);
		kernel.put("raiz de mandrágora",10.0);
		
		List<String> wood = new ArrayList<String>();
		wood.add("sabugueiro");
		wood.add("figueira");
		wood.add("cerejeira");
		wood.add("carvalho");
		wood.add("cedro");
		wood.add("macieira");
		wood.add("ipê");
		wood.add("salgueiro");
		
		DecimalFormat nf = new DecimalFormat("#0.00");
		double i = 20.0;
		while(i <= 31.5){
			double acc = Math.random() + 0.1;
			for(String w: wood){
				for(String k: kernel.keySet()){
					double r = Math.random();
					if(r * 20 <= kernel.get(k)){
						String insert = "INSERT INTO k_wand(wan_id, size, wood, "
								+ "kernel) values (uuid_generate_v1(), "+nf.format(i-Math.random()).replace(",", ".")+", "
								+ "'"+w+"', '"+k+"');";
						System.out.println(insert);
						if(Math.random() >= 0.9){
							System.out.println(insert);
						}
					}
				}
			}
			i += acc;
			
		}

	}
}
