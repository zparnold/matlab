/*
 * MATLAB Compiler: 5.2 (R2014b)
 * Date: Mon Mar 30 01:27:34 2015
 * Arguments: "-B" "macro_default" "-W" "java:featureCalculator" 
 * "featuresForSingleStreamOfData.m" 
 */

package featureCalculator;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class FeatureCalculatorMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "featureCalcu_DF8BDCEF326C58DA5180EB0AE9474F6C";
    
    /** Component name */
    private static final String sComponentName = "featureCalculator";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(FeatureCalculatorMCRFactory.class)
        );
    
    
    private FeatureCalculatorMCRFactory()
    {
        // Never called.
    }
    
    public static MWMCR newInstance(MWComponentOptions componentOptions) throws MWException
    {
        if (null == componentOptions.getCtfSource()) {
            componentOptions = new MWComponentOptions(componentOptions);
            componentOptions.setCtfSource(sDefaultComponentOptions.getCtfSource());
        }
        return MWMCR.newInstance(
            componentOptions, 
            FeatureCalculatorMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{8,4,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
