package manager;

public class Manager {
private int managerUniqueKey;
	
	private String managerId;
	
	private String managerPW;
	
	private String managerName;

	private int cafeUniqueKey;
	
	private String cafeName;    
	
	public Manager() {}
	
	public Manager(int cafeUniqueKey, String cafeName) {
		this.cafeUniqueKey = cafeUniqueKey;
		this.cafeName = cafeName;
	}

	public int getManagerUniqueKey() {
		return managerUniqueKey;
	}

	public void setManagerUniqueKey(int managerUniqueKey) {
		this.managerUniqueKey = managerUniqueKey;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public String getManagerPW() {
		return managerPW;
	}

	public void setManagerPW(String managerPW) {
		this.managerPW = managerPW;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	
	public int getCafeUniqueKey() {
		return cafeUniqueKey;
	}

	public void setCafeUniqueKey(int cafeUniqueKey) {
		this.cafeUniqueKey = cafeUniqueKey;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}
}
