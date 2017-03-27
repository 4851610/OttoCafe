package sales;

public class Sales {
	
    private int merchandiseUniqueKey;
    private String merchandiseName;
    private int materialPrice;
    private int cafeUniqueKey;
    private int cafeName;
    private int count;

    private int userUniqueKey;
    private String orderMenus;
    private String orderCounts;

     
    private int orderUniqueKey;
    
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

    public int getMaterialPrice() {
        return materialPrice;
    }

    public void setMaterialPrice(int materialPrice) {
        this.materialPrice = materialPrice;
    }

    public int getCafeUniqueKey() {
        return cafeUniqueKey;
    }

    public void setCafeUniqueKey(int cafeUniqueKey) {
        this.cafeUniqueKey = cafeUniqueKey;
    }

    public int getCafeName() {
        return cafeName;
    }

    public void setCafeName(int cafeName) {
        this.cafeName = cafeName;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    public int getUserUniqueKey() {
        return userUniqueKey;
    }

    public void setUserUniqueKey(int userUniqueKey) {
        this.userUniqueKey = userUniqueKey;
    }

    public String getOrderMenus() {
        return orderMenus;
    }

    public void setOrderMenus(String orderMenus) {
        this.orderMenus = orderMenus;
    }

    public String getOrderCounts() {
        return orderCounts;
    }

    public void setOrderCounts(String orderCounts) {
        this.orderCounts = orderCounts;
    }
    
    public int getOrderUniqueKey() {
		return orderUniqueKey;
	}

	public void setOrderUniqueKey(int orderUniqueKey) {
		this.orderUniqueKey = orderUniqueKey;
	}

	public Sales() {
    }

    public Sales(int merchandiseUniqueKey, String merchandiseName, int count) {
        this.merchandiseName = merchandiseName;
        this.count = count;
        this.merchandiseUniqueKey = merchandiseUniqueKey;
    }

    public Sales(int orderUniqueKey, int userUniqueKey, String menus, String couts) {
        this.orderUniqueKey=orderUniqueKey;
    	this.userUniqueKey = userUniqueKey;
        this.orderMenus = menus;
        this.orderCounts = couts;
    }

}
