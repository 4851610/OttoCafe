package stock;

public class Stock {
	private int materialUniqueKey;
	private String materialName;
	private float amount;
	private String materialUnitName;
	private String image;
	private int price;
	private int materialCategoryUniqueKey;
	private String categoryName;
	private int materialStoreUniqueKey;
	private String materialStoreName;
	private float volume;
	private String url;
	private int materialUnitUniqueKey;
	private int total;
	private int basketUniqueKey;
	private String date;
	private int totalPrice;
	private int count;
	private float minimum;
	private float usable;
	private float percentage;
	private int pageno;
	private int totalRecord;
	private int putBasketUniqueKey;

	/**
	 * 기본 생성자
	 * */
	public Stock() {
	}

	/**
	 * 마이페이지 재료 등록 리스트
	 * */
	public Stock(int materialUniqueKey, String categoryName,
			String materialStoreName, String materialName, String image,
			int price, float volume, String materialUnitName) {
		this.materialUniqueKey = materialUniqueKey;
		this.categoryName = categoryName;
		this.materialStoreName = materialStoreName;
		this.materialName = materialName;
		this.image = image;
		this.price = price;
		this.volume = volume;
		this.materialUnitName = materialUnitName;
	}

	/**
	 * 마이페이지 재료 등록
	 * */
	public Stock(int materialCategoryUniqueKey, int materialStoreUniqueKey,
			String materialName, String image, int price, String url,
			float volume, int materialUnitUniqueKey) {
		this.materialCategoryUniqueKey = materialCategoryUniqueKey;
		this.materialStoreUniqueKey = materialStoreUniqueKey;
		this.materialName = materialName;
		this.image = image;
		this.price = price;
		this.url = url;
		this.volume = volume;
		this.materialUnitUniqueKey = materialUnitUniqueKey;
	}

	/**
	 * 재고현황 재고 리스트
	 * */
	public Stock(int materialUniqueKey, String materialName, float amount,
			String materialUnitName, String image, int price) {
		this.materialUniqueKey = materialUniqueKey;
		this.materialName = materialName;
		this.amount = amount;
		this.materialUnitName = materialUnitName;
		this.image = image;
		this.price = price;
	}

	/**
	 * 장바구니 리스트
	 * */
	public Stock(int materialUniqueKey, String materialName, String image,
			int price, float amount, int total, int putBasketUniqueKey) {
		this.materialUniqueKey = materialUniqueKey;
		this.materialName = materialName;
		this.image = image;
		this.price = price;
		this.amount = amount;
		this.total = total;
		this.putBasketUniqueKey = putBasketUniqueKey;
	}

	/**
	 * 주문 히스토리 리스트
	 * */
	public Stock(int basketUniqueKey, String date, int totalPrice, String materialName, int count) {
		this.basketUniqueKey = basketUniqueKey;
		this.date = date;
		this.totalPrice = totalPrice;
		this.materialName = materialName;
		this.count = count;
	}
	
	/**
	 * 주문 히스토리 디데일
	 * */
	public Stock(int materialUniqueKey, String materialName, String image, int price, int total) {
		this.materialUniqueKey = materialUniqueKey;
		this.materialName = materialName;
		this.image = image;
		this.price = price;
		this.total = total;
	}
	
	/**
	 * 재료 등록 카테고리 리스트
	 * */
	public Stock(int materialCategoryUniqueKey, String categoryName) {
		this.materialCategoryUniqueKey = materialCategoryUniqueKey;
		this.categoryName = categoryName;
	}
	
	/**
	 * 재료 등록 재료 단위 리스트
	 * */
	public Stock(String materialUnitName, int materialUnitUniqueKey) {
		this.materialUnitName = materialUnitName;
		this.materialUnitUniqueKey = materialUnitUniqueKey;
	}
	
	/**
	 * 재료 그래프
	 * @param percentage 
	 * */
	public Stock(int materialUniqueKey, String materialName, int amount, float minimum, float percentage, float usable) {
		this.materialUniqueKey = materialUniqueKey;
		this.materialName = materialName;
		this.amount = amount;
		this.minimum = minimum;
		this.percentage = percentage;
		this.usable = usable;
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getMaterialStoreName() {
		return materialStoreName;
	}

	public void setMaterialStoreName(String materialStoreName) {
		this.materialStoreName = materialStoreName;
	}

	public float getVolume() {
		return volume;
	}

	public void setVolume(float volume) {
		this.volume = volume;
	}

	public int getMaterialCategoryUniqueKey() {
		return materialCategoryUniqueKey;
	}

	public void setMaterialCategoryUniqueKey(int materialCategoryUniqueKey) {
		this.materialCategoryUniqueKey = materialCategoryUniqueKey;
	}

	public int getMaterialStoreUniqueKey() {
		return materialStoreUniqueKey;
	}

	public void setMaterialStoreUniqueKey(int materialStoreUniqueKey) {
		this.materialStoreUniqueKey = materialStoreUniqueKey;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getMaterialUnitUniqueKey() {
		return materialUnitUniqueKey;
	}

	public void setMaterialUnitUniqueKey(int materialUnitUniqueKey) {
		this.materialUnitUniqueKey = materialUnitUniqueKey;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getBasketUniqueKey() {
		return basketUniqueKey;
	}

	public void setBasketUniqueKey(int basketUniqueKey) {
		this.basketUniqueKey = basketUniqueKey;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public float getMinimum() {
		return minimum;
	}

	public void setMinimum(float minimum) {
		this.minimum = minimum;
	}

	public float getUsable() {
		return usable;
	}

	public void setUsable(int usbale) {
		this.usable = usbale;
	}

	public float getPercentage() {
		return percentage;
	}

	public void setPercentage(int percentage) {
		this.percentage = percentage;
	}

	public int getPageno() {
		return pageno;
	}

	public void setPageno(int pageno) {
		this.pageno = pageno;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getPutBasketUniqueKey() {
		return putBasketUniqueKey;
	}

	public void setPutBasketUniqueKey(int putBasketUniqueKey) {
		this.putBasketUniqueKey = putBasketUniqueKey;
	}
}
