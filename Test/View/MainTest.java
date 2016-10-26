package View;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

/**
 * @author Ulrika Goloconda Fahlén
 * @version 1.0
 * @since 2016-10-25
 */
public class MainTest {
    Main main;
    @Before
    public void setUp() throws Exception {
       main = new Main();
    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void showLoginView() throws Exception {

        main.showLoginView();
    }

    @Test
    public void showNewUserView() throws Exception {
        main.showNewUserView();
    }

    @Test
    public void showMainView() throws Exception {

    }

    @Test
    public void showChangeUserView() throws Exception {

    }

    @Test
    public void showStatView() throws Exception {

    }

    @Test
    public void showStatView1() throws Exception {

    }

    @Test
    public void showDeleteView() throws Exception {

    }

    @Test
    public void showAdeminView() throws Exception {

    }

    @Test
    public void showAddBikeView() throws Exception {

    }

}