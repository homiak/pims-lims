/**
 * pims-web org.pimslims.servlet.complex ComplexDecorator.java
 * 
 * @author Marc Savitsky
 * @date 18 Oct 2007
 * 
 * Protein Information Management System
 * @version: 1.3
 * 
 * Copyright (c) 2007 Marc Savitsky  *   * 
 * 
 */
package org.pimslims.servlet.complex;

import javax.servlet.http.HttpServletRequest;

import org.displaytag.decorator.TableDecorator;
import org.pimslims.presentation.ComplexBean;

/**
 * ComplexDecorator
 * 
 */
public class ComplexDecorator extends TableDecorator {

    /**
     * 
     */
    public ComplexDecorator() {
        super();
    }

    public String getLink() {
        // int index = this.getListIndex();
        ComplexBean bean = (ComplexBean) this.getCurrentRowObject();
        String contextPath = ((HttpServletRequest) this.getPageContext().getRequest()).getContextPath();
        String link =
            "<a href='" + contextPath + "/ViewComplex/" + bean.getBlueprintHook() + "'>"
                + " <img class='icon' src='" + contextPath + "/images/icons/viewup.gif' />" + "</a>";
        return link;
    }

}
