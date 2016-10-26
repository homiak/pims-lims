/**
 * V2_0-pims-web org.pimslims.servlet MockContext.java
 * 
 * @author cm65
 * @date 10 Dec 2007
 * 
 *       Protein Information Management System
 * @version: 1.3
 * 
 *           Copyright (c) 2007 cm65
 * 
 * 
 */
package org.pimslims.presentation.mock;

import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Enumeration;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

@Deprecated
// use MockServletContext
public class MockContext implements ServletContext {

    private final java.util.Map attributes = new java.util.HashMap();

    /**
     * {@inheritDoc}
     */
    public void log(final String arg0, final Throwable arg1) {
        System.out.println(arg0);
    }

    /**
     * {@inheritDoc}
     */
    public void log(final String arg0) {
        System.out.println(arg0);
    }

    /**
     * {@inheritDoc}
     */
    public Object getAttribute(final String arg0) {
        return this.attributes.get(arg0);
    }

    /**
     * {@inheritDoc}
     */
    public Enumeration getAttributeNames() {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public ServletContext getContext(final String arg0) {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public String getInitParameter(final String arg0) {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public Enumeration getInitParameterNames() {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public int getMajorVersion() {
        return 0;
    }

    /**
     * {@inheritDoc}
     */
    public String getMimeType(final String arg0) {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public int getMinorVersion() {
        return 0;
    }

    /**
     * {@inheritDoc}
     */
    public RequestDispatcher getNamedDispatcher(final String arg0) {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public String getRealPath(final String arg0) {
        return "WebContent" + arg0;
    }

    /**
     * {@inheritDoc}
     */
    public RequestDispatcher getRequestDispatcher(final String arg0) {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public URL getResource(final String arg0) throws MalformedURLException {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public InputStream getResourceAsStream(final String arg0) {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public Set getResourcePaths(final String arg0) {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public String getServerInfo() {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public void removeAttribute(final String arg0) {
        this.attributes.remove(arg0);
    }

    /**
     * {@inheritDoc}
     */
    public void setAttribute(final String arg0, final Object arg1) {
        this.attributes.put(arg0, arg1);
    }

    /**
     * {@inheritDoc}
     */
    @Deprecated
    public Servlet getServlet(final String arg0) throws ServletException {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    public String getServletContextName() {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    @Deprecated
    public Enumeration getServletNames() {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    @Deprecated
    public Enumeration getServlets() {
        return null;
    }

    /**
     * {@inheritDoc}
     */
    @Deprecated
    public void log(final Exception arg0, final String arg1) {
        /* empty */
    }

    /**
     * MockContext.getContextPath
     * 
     * @see javax.servlet.ServletContext#getContextPath()
     */
    public String getContextPath() {
        // // COULD implement
        return null;
    }

}
