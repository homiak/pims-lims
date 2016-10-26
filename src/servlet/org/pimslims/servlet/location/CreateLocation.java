/**
 * pims-web org.pimslims.servlet.location CreateLocation.java
 * 
 * @author Marc Savitsky
 * @date 9 Apr 2008
 * 
 *       Protein Information Management System
 * @version: 1.3
 * 
 *           Copyright (c) 2008 Marc Savitsky * *
 * 
 */
package org.pimslims.servlet.location;

/**
 * CreateLocation
 * 
 */

/*
 * Created on 18.07.2005 TODO Error Messages passing
 */

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.pimslims.dao.ReadableVersion;
import org.pimslims.dao.WritableVersion;
import org.pimslims.exception.AbortedException;
import org.pimslims.exception.AccessException;
import org.pimslims.exception.ConstraintException;
import org.pimslims.lab.ContainerUtility;
import org.pimslims.metamodel.MetaClass;
import org.pimslims.metamodel.ModelObject;
import org.pimslims.model.core.LabNotebook;
import org.pimslims.model.holder.Holder;
import org.pimslims.model.location.Location;
import org.pimslims.model.sample.Sample;
import org.pimslims.presentation.LocationBeanWriter;
import org.pimslims.presentation.ModelObjectBean;
import org.pimslims.presentation.ServletUtil;
import org.pimslims.presentation.sample.LocationBean;
import org.pimslims.servlet.Create;
import org.pimslims.servlet.PIMSServlet;

@Deprecated
// obsolete
public class CreateLocation extends Create {

    public static final long serialVersionUID = 123243546;

    /*
     * (non-Javadoc)
     * 
     * @see org.pimslims.servlet.PIMSServlet#getServletInfo()
     */
    @Override
    public String getServletInfo() {
        return "Create a model object";
    }

    /**
     * 
     */
    public CreateLocation() {
        super();
    }

    @Override
    public void doPost(final HttpServletRequest request, final HttpServletResponse response)
        throws ServletException, IOException {

        // Get a WritableVersion
        final WritableVersion version = this.getWritableVersion(request, response);
        String hook = null;
        try {
            final LocationBean lb = new LocationBean();
            lb.setName(request.getParameter("locationName"));
            lb.setType(request.getParameter("locationType"));
            lb.setTemperature(request.getParameter("locationTemperature"));
            lb.setTemperatureDisplayUnit(request.getParameter("locationTemperatureUnit"));
            lb.setPressure(request.getParameter("locationPressure"));
            lb.setPressureDisplayUnit(request.getParameter("locationPressureUnit"));

            final LabNotebook project = version.get(request.getParameter(PIMSServlet.LAB_NOTEBOOK_ID));
            assert project != null : "project should not be null";
            lb.setAccess(new ModelObjectBean(project));

            final String locationParent = request.getParameter("locationParent");
            if (null != locationParent && locationParent.length() > 0) {
                final ModelObject object = version.get(request.getParameter("locationParent"));
                lb.setParentLocation((Location) object);
            }

            final ModelObject modelObject = LocationBeanWriter.createNewLocation(version, lb);
            hook = modelObject.get_Hook();

            if (this.validString(request.getParameter("hostobject"))) {

                final String hostObjectHook = request.getParameter("hostobject");
                final ModelObject hostObject = version.get(hostObjectHook);

                if (hostObject instanceof org.pimslims.model.sample.Sample) {
                    ContainerUtility.move((Sample) hostObject, (Location) modelObject);
                }

                if (hostObject instanceof org.pimslims.model.holder.Holder) {
                    ContainerUtility.move((Holder) hostObject, (Location) modelObject);
                }

                if (hostObject instanceof org.pimslims.model.location.Location) {
                    final Location thisLocation = (Location) hostObject;
                    thisLocation.setLocation((Location) modelObject);
                }
                hook = hostObject.get_Hook();
            }

            version.commit();
        } catch (final ConstraintException e) {
            throw new ServletException(e);
        } catch (final AccessException e) {
            throw new ServletException(e);
        } catch (final AbortedException e) {
            throw new ServletException(e);
        } finally {
            if (!version.isCompleted()) {
                version.abort();
            }
        }
        // now show the new target
        PIMSServlet.redirectPost(response, request.getContextPath() + "/View/" + hook);
    }

    /**
     * {@inheritDoc}
     * 
     * @baseURL org.pimslims.model.target.Target:molecule?molecule=hook,hook,hook&OtherMolecules=hook,hook
     */
    @Override
    public void doGet(final HttpServletRequest request, final HttpServletResponse response)
        throws ServletException, IOException {

        if (!this.checkStarted(request, response)) {
            return;
        }
        response.getWriter();

        // get the class we are creating,
        // Path is e.g. Create/org.pimslims.model.people.organisation
        String pathInfo = "/org.pimslims.model.location.Location";
        if (pathInfo == null || pathInfo.length() < 1) {
            request.setAttribute("message", "The type to create has not been specified cannot proceed");
            final RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/OneMessage.jsp");
            dispatcher.forward(request, response);
            return;
        }

        final ReadableVersion rv = this.getReadableVersion(request, response);
        if (rv == null) {
            return;
        }

        ModelObject hostObject = null;
        if (null != request.getParameter("hostobject")) {
            final String hostObjectHook = request.getParameter("hostobject");
            hostObject = rv.get(hostObjectHook);
        }

        Map errorMessages = null;
        Map formValues = null;
        final HttpSession session = request.getSession(false);
        if (session != null) {
            errorMessages = (Map) session.getAttribute("errorMessages");
            formValues = (Map) session.getAttribute("formValues");
            final Map parms = formValues;
            if (parms != null) {
                for (final Iterator iter = parms.entrySet().iterator(); iter.hasNext();) {
                    final Map.Entry elem = (Map.Entry) iter.next();
                    System.out.println(elem.getKey() + " VAL: " + elem.getValue());
                }
            }

            session.removeAttribute("errorMessages");
            session.removeAttribute("formValues");
        }
        if (errorMessages == null) {
            errorMessages = Collections.synchronizedMap(new HashMap());
        }

        // TODO parse attributes names from request line and create html only
        // for requested attributes
        // hook=org.pimslims.model.target.Target:9879 = 9878(?)
        // org.pimslims.model.target.Target?molecule=hook,hook,hook&OtherMolecules=hook,hook
        /**
         * Note: org.pimslims.model.target.Target:molecule?molecule=hook,hook,hook&OtherMolecules=hook,hook
         * org.pimslims.model.target.Target:molecule - means create molecule for a Target
         * org.pimslims.model.target.Target:molecule:NaturalSource - means create NaturalSource for a molecule
         * for a Target the rest of hooks for roles are to the Target only!
         */

        //String cancelURL = ""; // default is front page
        pathInfo = pathInfo.substring(1);
        MetaClass metaClass = null;
        MetaClass mainMetaClass = null;
        final int columnp = pathInfo.indexOf(":");
        final boolean isRoleObject = columnp >= 0;
        String roleName = null;
        if (isRoleObject) {
            // URL was like org.pimslims.model.target.Target:molecule...
            // making a new molecule for a new target etc
            final String mainMetaClassName = pathInfo.substring(0, columnp);
            mainMetaClass = this.getModel().getMetaClass(mainMetaClassName);

            if (mainMetaClass == null) {
                request.setAttribute("message", "Unknown object type. The metaclass was not set.");
                final RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/OneMessage.jsp");
                dispatcher.forward(request, response);
                return;
            }
            // Means that role represented by Abstract class, the concrite class
            // is defined by given index in the Set of subclasses
            final int star = pathInfo.indexOf("*");
            int setIndx;
            if (star >= 0) {
                setIndx = Integer.parseInt(pathInfo.substring(columnp + 1, star));
                roleName = pathInfo.substring(star + 1);
                metaClass = ServletUtil.getMetaClassForAbstractRole(mainMetaClass, roleName, setIndx);
            } else {
                roleName = pathInfo.substring(columnp + 1);
                metaClass = ServletUtil.getMetaClassForRole(mainMetaClass, roleName);
                //cancelURL = "Create/" + mainMetaClass.getMetaClassName();
            }

        } else {
            mainMetaClass = this.getModel().getMetaClass(pathInfo);
            if (mainMetaClass == null) {
                request.setAttribute("message", "Unknown object type. The metaclass was not set.");
                final RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/OneMessage.jsp");
                dispatcher.forward(request, response);
                return;
            }
            metaClass = mainMetaClass;
        }

        if (mainMetaClass.isAbstract()) {
            request.setAttribute("metaClass", mainMetaClass);
            final RequestDispatcher dispatcher =
                request.getRequestDispatcher("/JSP/create/CreateAbstract.jsp");
            dispatcher.forward(request, response);
            return;
        }
        if (metaClass == null) {
            request.setAttribute("message", "Unknown object type. The metaclass was not set.");
            final RequestDispatcher dispatcher = request.getRequestDispatcher("/JSP/OneMessage.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            //final Collection objects = rv.getAll(org.pimslims.model.location.Location.class);
            final Collection objects = PIMSServlet.getAll(rv, org.pimslims.model.location.Location.class);

            final Map parms = request.getParameterMap();
/*
            RoleHooksHolder hooks = null;
            if (parms != null && parms.size() > 0) {
                hooks = new RoleHooksHolder(mainMetaClass);
                hooks.parse(parms);
            } */

            /*final AttributeValueMap attributeValues = new AttributeValueMap(mainMetaClass, parms);
            if (null != formValues) {
                attributeValues.putAll(formValues);
            }*/

            // TODO rewrite as a page hidden parameter

            //final MetaClass pmeta = metaClass;

            /*
            final CustomGetter customget =
                new CustomGetter(rv, pmeta, errorMessages, ServletUtil.getSortedAttributes(attributes),
                    attributeValues, roles, mainMetaClass, hooks, request.getContextPath());

            
            //customget.getMissed(errorMessages);
            //request.setAttribute("helptext", customget.getHelpText());
            // request.setAttribute("missedErrorFields",
            // customget.getMissed(errorMessages));

            //request.setAttribute("headerTitle", customget.getTitle());
            //request.setAttribute("reqAttr", customget.reqAttrhtml);
            //request.setAttribute("optAttr", customget.optAttrhtml);
            //request.setAttribute("optRoles", customget.getOptRoleshtml());
            //request.setAttribute("reqRoles", customget.getReqRoleshtml());
            //request.setAttribute("readOnly", customget.readOnly ? "disabled" : "");
            //request.setAttribute("resetAction", customget.resetAction);
            //request.setAttribute("javascript", customget.javascript);
            //request.setAttribute("cancelURL", cancelURL); // relative URL for page if cancel clicked
            */
            request.setAttribute("locations", objects);
            request.setAttribute("accessObjects", PIMSServlet.getPossibleCreateOwners(rv));
            request.setAttribute("errorMessages", errorMessages);
            //request.setAttribute("owner", rv.getDefaultOwner(mainMetaClass, null));
            request.setAttribute("mainclass", mainMetaClass);
            request.setAttribute("roleName", roleName);
            request.setAttribute("hostObject", hostObject);
            request.setAttribute("metaclass", metaClass);

            request.setAttribute("pathInfo", pathInfo);

            for (final Iterator it = parms.entrySet().iterator(); it.hasNext();) {
                final Map.Entry e = (Map.Entry) it.next();
                final String[] values = (String[]) e.getValue();
                request.setAttribute((String) e.getKey(), values[0]);
            }

            final RequestDispatcher dispatcher =
                request.getRequestDispatcher("/JSP/location/CreateLocation.jsp");
            dispatcher.forward(request, response);

            rv.commit();
        } catch (final AbortedException e) {
            throw new ServletException(e);
        } catch (final ConstraintException e) {
            throw new ServletException(e);
        } finally {
            if (!rv.isCompleted()) {
                rv.abort();
            }
        }
    }

    private boolean validString(final String s) {
        if (null != s && s.length() > 0) {
            return true;
        }
        return false;
    }

}
