package merchandise;

public class Merchandise {
	
	private int merchandiseUniqueKey;
	private String merchandiseName;
	private int price;
	private String image;
	private int materialUniqueKey;
	private String materialName;
	private String categoryName;
	private float amount;
	private String materialUnitName;
	private int includeMaterialUniqueKey;
	
	public Merchandise() {}
	public Merchandise(int merchandiseUniqueKey, String merchandiseName, int price, String image) {
		//this.count = count;
		this.merchandiseUniqueKey = merchandiseUniqueKey;
		this.merchandiseName = merchandiseName;
		this.price = price;
		this.image = image;
	}
	public Merchandise(int includeMaterialUniqueKey, int materialUniqueKey, String materialName, String categoryName, float amount, String materialUnitName, String image) {
		this.includeMaterialUniqueKey = includeMaterialUniqueKey;
		this.materialUniqueKey = materialUniqueKey;
		this.materialName = materialName;
		this.categoryName = categoryName;
		this.amount = amount;
		this.materialUnitName = materialUnitName;
		this.image = image;
	}
	public int getMerchandiseUniqueKey() {
		return merchandiseUniqueKey;
	}
	public void setMerchandiseUniqueKey(int merchandiseUniqueKey) {
		this.merchandiseUniqueKey = merchandiseUniqueKey;
	}
	public String getMerchandiseName() {
		return merchandiseName;
	}
	public void setMerchandiseName(String merchandiseName) {
		this.merchandiseName = merchandiseName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getMaterialUniqueKey() {
		return materialUniqueKey;
	}
	public void setMaterialUniqueKey(int materialUniqueKey) {
		this.materialUniqueKey = materialUniqueKey;
	}
	public String getMaterialName() {
		return materialName;
	}
	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}
	public String getMaterialUnitName() {
		return materialUnitName;
	}
	public void setMaterialUnitName(String materialUnitName) {
		this.materialUnitName = materialUnitName;
	}
	public int getIncludeMaterialUniqueKey() {
		return includeMaterialUniqueKey;
	}
	public void setIncludeMaterialUniqueKey(int includeMaterialUniqueKey) {
		this.includeMaterialUniqueKey = includeMaterialUniqueKey;
	}
}
