package br.edu.ufcg.splab.test;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import junit.framework.Assert;
import org.junit.Test;
import org.loadui.testfx.Assertions;
import org.loadui.testfx.GuiTest;
import org.loadui.testfx.controls.Commons;

import java.io.IOException;

/**
 * Created by jordaoesa on 21/07/2016.
 */
public class MyTest extends GuiTest {

    @Override
    protected Parent getRootNode() {
        Parent parent = null;
        try {
            parent = FXMLLoader.load(getClass().getResource("/view/root.fxml"));
            return parent;
        } catch (IOException iex) {
            iex.printStackTrace();
        }
        return parent;
    }

    @Test
    public void test() {
        TextField firstname = find("#firstname");
        firstname.setText("jordao");
        Assertions.verifyThat("#firstname", Commons.hasText("jordao"));

        TextField lastname = find("#lastname");
        lastname.setText("serafim");
        Assertions.verifyThat("#lastname", Commons.hasText("serafim"));

        Button clickButton = find("#clickButton");
        Assert.assertFalse(clickButton.disableProperty().get());
    }
}
