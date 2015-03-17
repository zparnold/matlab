/*
 * MATLAB Compiler: 5.2 (R2014b)
 * Date: Mon Mar 16 20:27:33 2015
 * Arguments: "-B" "macro_default" "-W" "java:mycomponent,myclass" 
 * "featuresForSingleStreamOfData.m" "-v" 
 */

package mycomponent;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class MycomponentMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "mycomponent_3E49F6E94ABF4DC49D5FFB29ACA11229";
    
    /** Component name */
    private static final String sComponentName = "mycomponent";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(MycomponentMCRFactory.class)
        );
    
    
    private MycomponentMCRFactory()
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
            MycomponentMCRFactory.class, 
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
