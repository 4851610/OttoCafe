package store;

public class Store {

	private int storeUniqueKey;
	private String storeName;
	private String storeHomepage;
	private String storeTel;
	private String storeRepresentative;
	
	
	public Store() {}
	
	/**
	 * 거래처 리스트
	 * */
	public Store(int storeUniqueKey, String storeName, String storeHomepage, String storeTel, String storeRepresentative) {
		this.storeUniqueKey = storeUniqueKey;
		this.storeName = storeName;
		this.storeHomepage = storeHomepage;
		this.storeTel = storeTel;
		this.storeRepresentative = storeRepresentative;
	}
	
	/**
	 * 거래처 등록
	 * */
	public Store(String storeName, String storeHomepage, String storeTel, String storeRepresentative) {
		this.storeName = storeName;
		this.storeHomepage = storeHomepage;
		this.storeTel = storeTel;
		this.storeRepresentative = storeRepresentative;
	}
	
	/**
	 * 재료등록 거래처 리스트
	 * */
	public Store(int storeUniqueKey, String storeName) {
		this.storeUniqueKey = storeUniqueKey;
		this.storeName = storeName;
	}
	
	public int getStoreUniqueKey() {
		return storeUniqueKey;
	}

	public void setStoreUniqueKey(int storeUniqueKey) {
		this.storeUniqueKey = storeUniqueKey;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStoreHomepage() {
		return storeHomepage;
	}

	public void setStoreHomepage(String storeHomepage) {
		this.storeHomepage = storeHomepage;
	}

	public String getStoreTel() {
		return storeTel;
	}

	public void setStoreTel(String storeTel) {
		this.storeTel = storeTel;
	}

	public String getStoreRepresentative() {
		return storeRepresentative;
	}

	public void setStoreRepresentative(String storeRepresentative) {
		this.storeRepresentative = storeRepresentative;
	}
}
