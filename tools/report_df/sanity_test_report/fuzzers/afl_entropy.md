---
title: afl_entropy
---


{% capture template %}



<div class="section">
    <h1>afl_entropy</h1>
    <p>
        This page shows the distribution of time-to-bug measurements for every bug reached and/or triggered by the
        fuzzer. The results are grouped by target to highlight any performance trends the fuzzer may have against
        specific targets.
    </p>

    
    <h2>libpng</h2>
    
        
        <h3>libpng_read_fuzzer</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libpng_libpng_read_fuzzer_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libpng_libpng_read_fuzzer_triggered.svg">
            </div>
        
        </div>
    

    
    <h2>libsndfile</h2>
    
        
        <h3>sndfile_fuzzer</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libsndfile_sndfile_fuzzer_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libsndfile_sndfile_fuzzer_triggered.svg">
            </div>
        
        </div>
    

    
    <h2>libxml2</h2>
    
        
        <h3>libxml2_xml_read_memory_fuzzer</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libxml2_libxml2_xml_read_memory_fuzzer_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libxml2_libxml2_xml_read_memory_fuzzer_triggered.svg">
            </div>
        
        </div>
    
        
        <h3>xmllint</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libxml2_xmllint_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_libxml2_xmllint_triggered.svg">
            </div>
        
        </div>
    

    
    <h2>lua</h2>
    
        
        <h3>lua</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_lua_lua_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_lua_lua_triggered.svg">
            </div>
        
        </div>
    

    
    <h2>openssl</h2>
    
        
        <h3>asn1</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_asn1_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_asn1_triggered.svg">
            </div>
        
        </div>
    
        
        <h3>asn1parse</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_asn1parse_reached.svg">
            </div>
        
        </div>
    
        
        <h3>bignum</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_bignum_reached.svg">
            </div>
        
        </div>
    
        
        <h3>client</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_client_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_client_triggered.svg">
            </div>
        
        </div>
    
        
        <h3>server</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_server_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_server_triggered.svg">
            </div>
        
        </div>
    
        
        <h3>x509</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_openssl_x509_reached.svg">
            </div>
        
        </div>
    

    
    <h2>php</h2>
    
        
        <h3>exif</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_php_exif_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_php_exif_triggered.svg">
            </div>
        
        </div>
    

    
    <h2>poppler</h2>
    
        
        <h3>pdf_fuzzer</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_poppler_pdf_fuzzer_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_poppler_pdf_fuzzer_triggered.svg">
            </div>
        
        </div>
    
        
        <h3>pdfimages</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_poppler_pdfimages_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_poppler_pdfimages_triggered.svg">
            </div>
        
        </div>
    
        
        <h3>pdftoppm</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_poppler_pdftoppm_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_poppler_pdftoppm_triggered.svg">
            </div>
        
        </div>
    

    
    <h2>sqlite3</h2>
    
        
        <h3>sqlite3_fuzz</h3>
        <div class="row">
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_sqlite3_sqlite3_fuzz_reached.svg">
            </div>
        
            
            <div class="col s6">
                <img class="materialboxed responsive-img" src="../plot/box_afl_entropy_sqlite3_sqlite3_fuzz_triggered.svg">
            </div>
        
        </div>
    

</div>



{% endcapture %}
{{ template | replace: '    ', ''}}
