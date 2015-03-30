/*
 * MATLAB Compiler: 5.2 (R2014b)
 * Date: Mon Mar 30 01:27:34 2015
 * Arguments: "-B" "macro_default" "-W" "java:featureCalculator" 
 * "featuresForSingleStreamOfData.m" 
 */

package featureCalculator;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;
import java.util.*;

/**
 * The <code>featureCalculator</code> class provides a Java interface to the M-functions
 * from the files:
 * <pre>
 *  featuresForSingleStreamOfData.m
 * </pre>
 * The {@link #dispose} method <b>must</b> be called on a <code>featureCalculator</code> 
 * instance when it is no longer needed to ensure that native resources allocated by this 
 * class are properly freed.
 * @version 0.0
 */
public class featureCalculator extends MWComponentInstance<featureCalculator>
{
    /**
     * Tracks all instances of this class to ensure their dispose method is
     * called on shutdown.
     */
    private static final Set<Disposable> sInstances = new HashSet<Disposable>();

    /**
     * Maintains information used in calling the 
     *<code>featuresForSingleStreamOfData</code> M-function.
     */
    private static final MWFunctionSignature sFeaturesForSingleStreamOfDataSignature =
        new MWFunctionSignature(/* max outputs = */ 1,
                                /* has varargout = */ false,
                                /* function name = */ "featuresForSingleStreamOfData",
                                /* max inputs = */ 4,
                                /* has varargin = */ false);

    /**
     * Shared initialization implementation - private
     */
    private featureCalculator (final MWMCR mcr) throws MWException
    {
        super(mcr);
        // add this to sInstances
        synchronized(featureCalculator.class) {
            sInstances.add(this);
        }
    }

    /**
     * Constructs a new instance of the <code>featureCalculator</code> class.
     */
    public featureCalculator() throws MWException
    {
        this(FeatureCalculatorMCRFactory.newInstance());
    }
    
    private static MWComponentOptions getPathToComponentOptions(String path)
    {
        MWComponentOptions options = new MWComponentOptions(new MWCtfExtractLocation(path),
                                                            new MWCtfDirectorySource(path));
        return options;
    }
    
    /**
     * @deprecated Please use the constructor {@link #featureCalculator(MWComponentOptions componentOptions)}.
     * The <code>com.mathworks.toolbox.javabuilder.MWComponentOptions</code> class provides API to set the
     * path to the component.
     * @param pathToComponent Path to component directory.
     */
    public featureCalculator(String pathToComponent) throws MWException
    {
        this(FeatureCalculatorMCRFactory.newInstance(getPathToComponentOptions(pathToComponent)));
    }
    
    /**
     * Constructs a new instance of the <code>featureCalculator</code> class. Use this 
     * constructor to specify the options required to instantiate this component.  The 
     * options will be specific to the instance of this component being created.
     * @param componentOptions Options specific to the component.
     */
    public featureCalculator(MWComponentOptions componentOptions) throws MWException
    {
        this(FeatureCalculatorMCRFactory.newInstance(componentOptions));
    }
    
    /** Frees native resources associated with this object */
    public void dispose()
    {
        try {
            super.dispose();
        } finally {
            synchronized(featureCalculator.class) {
                sInstances.remove(this);
            }
        }
    }
  
    /**
     * Invokes the first m-function specified by MCC, with any arguments given on
     * the command line, and prints the result.
     */
    public static void main (String[] args)
    {
        try {
            MWMCR mcr = FeatureCalculatorMCRFactory.newInstance();
            mcr.runMain( sFeaturesForSingleStreamOfDataSignature, args);
            mcr.dispose();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }
    
    /**
     * Calls dispose method for each outstanding instance of this class.
     */
    public static void disposeAllInstances()
    {
        synchronized(featureCalculator.class) {
            for (Disposable i : sInstances) i.dispose();
            sInstances.clear();
        }
    }

    /**
     * Provides the interface for calling the <code>featuresForSingleStreamOfData</code> M-function 
     * where the first input, an instance of List, receives the output of the M-function and
     * the second input, also an instance of List, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %calulate the number of steps for each trial
     * </pre>
     * </p>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void featuresForSingleStreamOfData(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sFeaturesForSingleStreamOfDataSignature);
    }

    /**
     * Provides the interface for calling the <code>featuresForSingleStreamOfData</code> M-function 
     * where the first input, an Object array, receives the output of the M-function and
     * the second input, also an Object array, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %calulate the number of steps for each trial
     * </pre>
     * </p>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void featuresForSingleStreamOfData(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sFeaturesForSingleStreamOfDataSignature);
    }

    /**
     * Provides the standard interface for calling the <code>featuresForSingleStreamOfData</code>
     * M-function with 4 input arguments.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %calulate the number of steps for each trial
     * </pre>
     * </p>
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] featuresForSingleStreamOfData(int nargout, Object... rhs) throws MWException
    {
        Object[] lhs = new Object[nargout];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sFeaturesForSingleStreamOfDataSignature), 
                    sFeaturesForSingleStreamOfDataSignature);
        return lhs;
    }
}
