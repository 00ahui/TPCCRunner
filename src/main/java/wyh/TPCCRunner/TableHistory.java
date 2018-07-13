package wyh.TPCCRunner;

import java.io.Serializable;

/**
 * Table history
 * 
 * @author "Yaohui Wang"
 * @version 1.00
 */
public class TableHistory implements Serializable {
	private static final long serialVersionUID = -615301850210746377L;
	public int h_c_id;
	public int h_c_d_id;
	public int h_c_w_id;
	public int h_d_id;
	public int h_w_id;
	public long h_date;
	public float h_amount;
	public String h_data;

	public String toString() {
		StringBuffer desc = new StringBuffer();
		desc.append("\n***************** History ********************");
		desc.append("\n*   h_c_id = " + h_c_id);
		desc.append("\n* h_c_d_id = " + h_c_d_id);
		desc.append("\n* h_c_w_id = " + h_c_w_id);
		desc.append("\n*   h_d_id = " + h_d_id);
		desc.append("\n*   h_w_id = " + h_w_id);
		desc.append("\n*   h_date = " + h_date);
		desc.append("\n* h_amount = " + h_amount);
		desc.append("\n*   h_data = " + h_data);
		desc.append("\n**********************************************");
		return desc.toString();
	}
}