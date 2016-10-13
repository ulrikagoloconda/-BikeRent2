package View;

/**
 * @authorUlrika, Goloconda Fahlén
 * @version 1.0
 * @since 2016-09-20
 */
public class SpiderView {
    private  AddBikeController addBikeView;
    private AdminViewController adminView;
    //private ChangeUserTry changeUserTry;
    private changeUserVewController changeUserVewController;
    private DeleteBikeViewController deleteView;
    private loginVewController loginView;
    private MainVewController mainView;
    private newUserVewController newUserView;
    private ChangeUserTry changeUserTry;
    private StatViewController statViewController;
    private Main main;

    public SpiderView( ){

    }

    public AddBikeController getAddBikeView() {
        return addBikeView;
    }

    public void setAddBikeView(AddBikeController addBikeView) {
        this.addBikeView = addBikeView;
    }

    public AdminViewController getAdminView() {
        return adminView;
    }

    public void setAdminView(AdminViewController adminView) {
        this.adminView = adminView;
    }

    //public ChangeUserTry getChangeUserTry() {
    //    return changeUserTry;
    //}

    //public void setChangeUserTry(ChangeUserTry changeUserTry) {
    //    this.changeUserTry = changeUserTry;
    //}

    public View.changeUserVewController getChangeUserVewController() {
        return changeUserVewController;
    }

    public void setChangeUserVewController(View.changeUserVewController changeUserVewController) {
        this.changeUserVewController = changeUserVewController;
    }

    public DeleteBikeViewController getDeleteView() {
        return deleteView;
    }

    public void setDeleteView(DeleteBikeViewController deleteView) {
        this.deleteView = deleteView;
    }

    public loginVewController getLoginView() {
        return loginView;
    }

    public void setLoginView(loginVewController loginView) {
        this.loginView = loginView;
    }

    public MainVewController getMainView() {
        return mainView;
    }

    public void setMainView(MainVewController mainView) {
        this.mainView = mainView;
    }

    public Main getMain() {
        return main;
    }

    public void setMain(Main main) {
        this.main = main;
    }

    public newUserVewController getNewUserView() {
        return newUserView;
    }

    public void setNewUserView(newUserVewController newUserView) {
        this.newUserView = newUserView;
    }

    public void setChangeUserTry(ChangeUserTry changeUserTry) {
        this.changeUserTry = changeUserTry;
    }

    public ChangeUserTry getChangeUserView(){
        return changeUserTry;
    }

    public void setStatViewContrller(StatViewController statViewController) {
        this.statViewController = statViewController;
    }
    public StatViewController getStatViewController(){
        return statViewController;
    }
}
