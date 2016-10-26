/**
 * current-pims-web org.pimslims.utils.experiment Utils.java
 * 
 * @author pvt43
 * @date 17 Jul 2008
 * 
 *       Protein Information Management System
 * @version: 1.3
 * 
 *           Copyright (c) 2008 pvt43 Foundation; either *
 * 
 */
package org.pimslims.utils.experiment;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.pimslims.dao.ReadableVersion;
import org.pimslims.dao.ReadableVersionImpl;
import org.pimslims.dao.WritableVersion;
import org.pimslims.exception.AccessException;
import org.pimslims.exception.ConstraintException;
import org.pimslims.lab.Util;
import org.pimslims.metamodel.ModelObject;
import org.pimslims.model.core.LabBookEntry;
import org.pimslims.model.experiment.Experiment;
import org.pimslims.model.experiment.InputSample;
import org.pimslims.model.experiment.OutputSample;
import org.pimslims.model.experiment.Parameter;
import org.pimslims.model.molecule.Molecule;
import org.pimslims.model.molecule.Substance;
import org.pimslims.model.protocol.ParameterDefinition;
import org.pimslims.model.protocol.Protocol;
import org.pimslims.model.reference.SampleCategory;
import org.pimslims.model.sample.AbstractSample;
import org.pimslims.model.sample.Sample;
import org.pimslims.util.File;

/**
 * Utils
 * 
 */
public class Utils {

    public static final String ORDERNAMEPREFIX = "SO_";

    public static Collection<Sample> getAntibiotics(final ReadableVersion version) {
        final SampleCategory antibiotic =
            version.findFirst(SampleCategory.class, SampleCategory.PROP_NAME, "Antibiotic");
        final ArrayList<Sample> sl = new ArrayList<Sample>();
        for (final AbstractSample as : antibiotic.getAbstractSamples()) {
            if (as instanceof Sample) {
                sl.add((Sample) as);
            }
        }
        return sl;
    }

    /*
     * This should be called first time under administrator user from ant task "" 
     */
    public static Substance getRefComponent(final WritableVersion rw) throws AccessException,
        ConstraintException {
        final Map<String, Object> prop = Util.getNewMap();
        prop.put(Substance.PROP_NAME, "Dummy MolComponent");
        prop.put(Molecule.PROP_MOLTYPE, "other");
        prop.put(LabBookEntry.PROP_DETAILS, "used by WizardExperimentCreate for SampleComponent recording. "
            + "No meaningful information is recorded here. Needed to sutisfy mandatory relation.");
        return Util.getOrCreate(rw, Molecule.class, prop);
    }

    public static Integer getSize(final Object obj) {
        if (obj == null) {
            return 0;
        }

        if (obj instanceof Collection) {
            return ((Collection) obj).size();
        }
        if (obj instanceof Map) {
            return ((Map) obj).size();
        }
        if (obj instanceof String[]) {
            return ((String[]) obj).length;
        }
        if (obj instanceof String) {
            return ((String) obj).length();
        }
        return 0;
    }

    public static ParameterDefinition getParameterDefinition(final Protocol protocol, final String paramName) {
        for (final ParameterDefinition pd : protocol.getParameterDefinitions()) {
            if (pd.getName().equalsIgnoreCase(paramName)) {
                return pd;
            }
        }
        return null;
    }

    /**
     * This method generates field names for use by UpdateExperiment servlet
     * 
     * Utils.getFieldName
     * 
     * @param experiment
     * @param property
     * @return Input can be for Parameters : P.Template Name (i.e. "P." plus parameter name)
     * 
     *         return
     * 
     *         org.pimslims.model.experiment.Parameter:114069:value
     * 
     *         InputSamples I.Antibiotic or I.Antibiotic:Sample.PROP_DETAILS (i.e. "I." plus inputSample name)
     * 
     *         return
     * 
     *         org.pimslims.model.experiment.InputSample:114076:sample
     *         org.pimslims.model.experiment.InputSample:114076:value
     *         org.pimslims.model.experiment.InputSample:114076:unit
     * 
     *         OutputSamples O.Cell(i.e. "O." plus outputSample name)
     * 
     *         return
     * 
     *         org.pimslims.model.sample.Sample:114071:name org.pimslims.model.sample.Sample:114071:value
     *         org.pimslims.model.sample.Sample:114071:units
     * 
     */
    public static String getFieldName(final Experiment experiment, final String property) {

        String prop = null;
        // Parameter requested
        if (property.startsWith("P.")) {
            prop = property.substring("P.".length());
            final Parameter p = Utils.getParameter(experiment, prop);
            // Should be assert but its purely handled when in tag  
            if (p == null) {
                System.out.println("WARNING: Cannot find Parameter by Name '" + prop + "' in experiment "
                    + experiment);
            }
            return p.get_Hook() + ":" + Parameter.PROP_VALUE;
        }

        // InputSample requested
        if (property.startsWith("I.")) {
            prop = property.substring("I.".length());
            final int sep = prop.indexOf(":");
            String subProp = "";
            if (sep > 0) {
                subProp = prop.substring(sep);
                prop = prop.substring(0, sep - 1);
            }
            for (final InputSample inSample : experiment.getInputSamples()) {
                if (inSample.getName().equalsIgnoreCase(prop)) {
                    return subProp.length() > 0 ? inSample.get_Hook() + ":" + subProp : inSample.get_Hook()
                        + ":" + InputSample.PROP_SAMPLE;
                }
            }
        }

        // OutputSample requested
        if (property.startsWith("O.")) {
            prop = property.substring("O.".length());
            final int sep = prop.indexOf(":");
            String subProp = "";
            if (sep > 0) {
                subProp = prop.substring(sep);
                prop = prop.substring(0, sep - 1);
            }
            for (final OutputSample outSample : experiment.getOutputSamples()) {
                if (outSample.getName().equalsIgnoreCase(prop)) {
                    return subProp.length() > 0 ? outSample.get_Hook() + ":" + subProp : outSample.get_Hook()
                        + ":" + OutputSample.PROP_SAMPLE;
                }
            }

        }

        return "";
    }

    public static Parameter getParameter(final Experiment experiment, final String pname) {

        for (final Parameter p : experiment.getParameters()) {
            final String paramName = p.getName();
            if (!Util.isEmpty(paramName) && paramName.trim().equalsIgnoreCase(pname.trim())) {
                return p;
            }
        }

        return null;
    }

    public static String getWizardParameterValue(final Experiment experiment, final String pname) {

        // Parameter requested
        assert (!Util.isEmpty(pname) && pname.startsWith("P.")) : "WARNING Parameter property should not be NULL and should start with 'P.' ! Current value is: "
            + pname;

        if (experiment == null) {
            System.out.println("WARNING: Experiment is NULL! ");
            return "";
        }

        final String prop = pname.substring("P.".length());
        final Parameter p = Utils.getParameter(experiment, prop);
        if (p == null) {
            System.out.println("getWizardParameterValue():WARNING: Cannot find Parameter by Name '" + prop
                + "' in experiment " + experiment);
        }
        return p != null ? p.getValue() : "";

    }

    public static String getParameterValue(final Experiment experiment, final String pname) {

        // Parameter requested
        assert (!Util.isEmpty(pname)) : "WARNING Parameter property should not be NULL! Current value is: "
            + pname;

        if (experiment == null) {
            System.out.println("WARNING: Experiment is NULL! ");
            return "";
        }

        final Parameter p = Utils.getParameter(experiment, pname);
        if (p == null) {
            System.out.println("getParameterValue():WARNING: Cannot find Parameter by Name '" + pname
                + "' in experiment " + experiment);
        }
        return p != null ? p.getValue() : "";

    }

    /*
     * key: ${exp._Hook}:Experiment.PROP_DETAILS
     * This should not be used with any complex values! 
     * This need TLD definition
     */
    public static String getObjectSimpleProperty(final String key, final ReadableVersion rv) {
        final int sep = key.lastIndexOf(":");
        if (sep < 0) {
            return "";
        }
        final String hook = key.substring(0, sep);
        if (!Util.isHookValid(hook)) {
            return "";
        }
        final ModelObject mo = rv.get(hook);
        if (mo == null) {
            return "";
        }
        final Object value = mo.get_Values().get(key.substring(sep + 1));

        return value.toString();
    }

    public static String getObjectSimpleProperty(final String prop, final ModelObject mObj) {
        // This should be an assert statement, but asserts are not handled nicely 
        // if they are in the custom EL function call

        if (mObj == null) {
            return "";
        }
        if (Util.isEmpty(prop)) {
            System.out.println("WARNING: No property must be specified for Value function!");
        }

        boolean propExist = false;
        for (final String key : mObj.get_Values().keySet()) {
            if (key.equals(prop)) {
                propExist = true;
                break;
            }
        }
        if (!propExist) {
            System.out.println("Requested property is not defined in the passed object! Property:" + prop
                + " Object:" + mObj);
        }
        return mObj.get_Value(prop).toString();
    }

    public synchronized static long getNextNumber(final ReadableVersion rv, final String dbSequenceName) {
        final ReadableVersionImpl rvim = (ReadableVersionImpl) rv;
        return rvim.getNextVal(dbSequenceName);
    }

    public static String getOrderId(final ReadableVersion rv) {
        final long next = Utils.getNextNumber(rv, "sequencingOrder");
        return Utils.ORDERNAMEPREFIX + next;
    }

    public static long getSeqRefNumber(final ReadableVersion rv) {
        final long next = Utils.getNextNumber(rv, "seqrefnum");
        return next;
    }

    public static ModelObject getFirstRecord(final List<ModelObject> objects) {
        if (!objects.isEmpty()) {
            return objects.iterator().next();
        }
        return null;
    }

    public static String getFastaName(String fastaSequence) {
        assert !Util.isEmpty(fastaSequence);
        final int nameStart = fastaSequence.indexOf(">");
        assert nameStart >= 0 : "Sequence does not seem to be in FASTA!";
        fastaSequence = fastaSequence.substring(nameStart);
        final int nameEnd = fastaSequence.indexOf("\n");
        assert nameEnd > 0 : "Cannot determine the end of the sequence name!";
        return fastaSequence.substring(1, nameEnd);
    }

    public static void reobtainCollection(final List<Experiment> experiments, final ReadableVersion rv) {
        assert experiments != null && !experiments.isEmpty();
        for (int i = 0; i < new ArrayList(experiments).size(); i++) {
            final Experiment staleExp = experiments.get(i);
            if (staleExp == null) {
                continue;
            }
            final Experiment revivedExp = rv.get(staleExp.get_Hook());
            experiments.set(i, revivedExp);
        }
    }

/*
    @Deprecated
    public static void linkExperiments(final ExperimentGroup eg, final List<Experiment> exps,
        final Holder holderForSSetupExps) throws ConstraintException {
        //Assume that the order of experiments in both collections is the same e.g. col1(0)= well A01 == col2(0)
        // The comparator arranges experiments in by their names. Their names has been generated using seqrefnum 
        // sequence and are in order of the rows in a spreadsheet

        final ArrayList<Experiment> expsWithOutput = new ArrayList<Experiment>(eg.getExperiments());
        Collections.sort(expsWithOutput, SequencingOrder.nameComporator);

        int counter = 0;
        assert expsWithOutput.size() == exps.size() : "The number of sequencing order experiments ("
            + expsWithOutput.size() + ") does not match the number if sequencing prep experiments ("
            + exps.size() + ")!";

        for (final Experiment outExp : expsWithOutput) {

            final Sample sample = Utils.getSampleFromOutput(outExp);
            assert sample != null : "No output sample found!";

            final Experiment sseExp = exps.get(counter);
            // Set the name of sequencing setup experiment the same as refnumber of sequencing order with prefix
            sseExp.setName(SeqSetupExperiment.EXP_NAME_PREFIX + outExp.getName());
            final Collection<InputSample> sseinSamples = sseExp.getInputSamples();
            for (final InputSample iSample : sseinSamples) {
                if (iSample.getName().equals("Template")) {
                    iSample.setSample(sample);
                    break;
                }
            }
            final Set<OutputSample> sseoutSamples = sseExp.getOutputSamples();

            assert sseoutSamples.size() == 1 : "Only one output sample is expected in Sequencing Setup Experiment but found "
                + sseoutSamples.size() + " Experiment: " + sseExp;
            final OutputSample oSample = sseoutSamples.iterator().next();
            // set Sample for Output for Sequencing Setup Experiment to position them the same way as Sequencing Order exps
            // Have to copy a sample as only one sample can be OutputSample. 
            final Sample sout = SampleUtility.copySample(sample);
            // Make sure to put these samples in the sample holder to be able to view them in a plate
            sout.setHolder(holderForSSetupExps);
            oSample.setSample(sout);
            counter++;
        }
    }
*/
    /*
    * PIMS well A1 but spreadsheet well must be A01 otherwise the sequencing robot will not recognise it
    */
    public static String convertWellNumber(final String wellNum) {
        assert wellNum != null : "Well number is not defined (NULL)!";
        // Determine direction e.g. A1 to A01 or the other way around 
        if (wellNum.trim().length() == 3) {
            final String midChar = wellNum.substring(1, 2);
            // return 10,11,12 columns without modification
            if (midChar.equals("0")) {
                return wellNum.substring(0, 1) + wellNum.substring(2);
            } else {
                // No need to convert e.g. columns 10,11,12 
                return wellNum;
            }
        }
        // Current format is PIMS return robotics format  
        if (wellNum.trim().length() == 2) {
            return new StringBuffer(wellNum).insert(1, "0").toString();
        }
        throw new AssertionError("Cannot recognise well number format! Given well name is:" + wellNum);
    }

    static String addedOrderStyle = "";

    public static Sample getSampleFromOutput(final Experiment experiment) {
        final Set<OutputSample> osamples = experiment.getOutputSamples();
        assert osamples.size() == 1 : "Only one sample expected! Cannot proceed. Experiment given is:"
            + experiment;
        return osamples.iterator().next().getSample();
    }

    public static Sample getSampleFromInput(final Experiment experiment, final String name) {
        final InputSample is = Utils.getInputSample(experiment, name);
        if (is != null) {
            return is.getSample();
        }
        return null;
    }

    public static InputSample getInputSample(final Experiment experiment, final String name) {
        final Collection<InputSample> isamples = experiment.getInputSamples();
        assert isamples.size() > 0;
        for (final InputSample isample : isamples) {
            if (isample.getName().equalsIgnoreCase(name)) {
                return isample;
            }
        }
        return null;
    }

    /**
     * 
     * Utils.getOtherFiles
     * 
     * @web function
     * @param exp
     * @return
     */
    public static Collection<File> getOtherFiles(final Experiment exp) {
        final Collection<File> files = new ArrayList<File>();
        for (final File file : exp.get_Files()) {
            if (file.getTitle().toLowerCase().endsWith(".seq")
                || file.getTitle().toLowerCase().endsWith(".ab1")
                || file.getTitle().toLowerCase().endsWith(".scf")) {
                // do not return 
            } else {
                files.add(file);
            }
        }
        return files;
    }

}
