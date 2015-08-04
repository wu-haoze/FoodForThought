//
//  IconDescription.swift
//  FoodForThought
//
//  Created by Wu, Andrew on 7/15/15.
//  Copyright (c) 2015 Davidson College Mobile App Team. All rights reserved.
//

import Foundation

struct IconDescription{
    let descriptions = [
        "FSD": "This dish was prepared from scratch.\n ",
        "FS": "This restaurant prepares meals from scratch. This seemingly simple cooking trick requires top-notch culinary skills and increases the restaurant’s menu flexibility.\n",
        "SE": "An ingredient in this dish is in season. Using seasonal ingredients reduces the need to source from non-local sources that can be thousands of miles away.\n",
        "LD": "An ingredient in this dish comes from a local producer, which maximizes freshness and taste.\n ",
        "L": "This restaurant provides food options from local farms that are within 250 miles. Local sourcing builds relationships between farmers, restaurant owners, and customers, which creates a sense of community and promotes the local economy.\n",
        "AI":  "The restaurant’s staff members are educated on common allergens and this information is available upon request. \n ",
        "CA":  "This restaurant offers catering services. Beneficial services provided by the restaurant can help build a sense of community and bring people together, which promotes social welfare.\n ",
        "FD":  "This restaurant frequently donates prepared food to charities, churches, or food banks. \n ",
        "MD":  "This restaurant frequently contributes monetary donations to charities.\n ",
        "VO":  "This restaurant promotes volunteering opportunities to its employees, such as helping run charity events, working at a soup kitchen or helping at a local farm.\n ",
        "C":  "This restaurant composts food scraps instead of sending them to the landfill. Restoring nutrients back to the soil supports all trophic levels through nutrient cycling.\n ",
        "LA":  "This restaurant sources alcoholic beverages from local breweries and wineries. This builds relationships between producers, restaurant owners, and customers, which creates a sense of community and promotes the local economy.\n ",
        "R":  "This restaurant recycles appropriate materials, such as cardboard, correct plastics, glass or certain metals. Promoting closed loop recycling cycles saves raw materials for future generations.\n ",
        
        "CE":  "This food item is a good source of carb energy. Carbohydrates are the body’s preferred source of fuel and provides important B vitamins and fiber. \n",
        "ES":  "This restaurant uses Energy Star appliances to reduce energy consumption. \n",
        "HF":  "This food item is a good source of healthy fat. Healthy fats add flavor and satiety to food, are heart healthy, prevent inflammation, aid in the absorption of fat-soluble vitamins, and provide energy.\n ",
        "PP":  "This food item is a good source of protein. Proteins are the building blocks of most body tissues and carry out metabolic properties, such as transporting oxygen throughout the body.\n ",
        "VN":  "This food item is rich in nutrients such as essential vitamins and minerals. Nutrient rich foods are important for immune system health, energy metabolism and disease prevention.\n ",
        
        "Humane": "This icon indicates that this dish\n",
        "Eco": "Ecologically Sound\n",
        "Fair": "Fair\n",
        
        "CBF": "Certified Bird Friendly coffee: this certification requires that the coffee is grown organically under a canopy of native trees, which avoids clear cutting, preserves migratory bird habitat, and improves carbon sequestration. \n",
        "CLS": "Certified Local Sustainable (Local Food Plus): this non-profit organization set specific standards for sustainable farming that \"balance economic, social and environmental considerations.\" These include avoiding growth hormones, synthetic pesticides/fertilizers and reduce greenhouse emissions.\n",
        "IFO": "International Federation of Organic Agriculture Movements: a non-profit organization that created a globally accepted standard for organic. Their mission is to promote more than just organic foods, but to also advance health, ecology, fairness, and care.\n",
        "DCB" : "Demeter Certified Biodynamic: \"a comprehensive organic farming method that requires the creation and management of a closed system minimally dependent on imported materials, and instead meets its needs from the living dynamics of the farm itself.\" \n",
        "EUO" : "European Union Organic: focuses on the entire supply chain to ensure every link along the chain adheres to strict regulations. They seek to indorse environmental protection, food quality, animal welfare and consumer confidence.\n",
        "FAC" : "Food Alliance Certified: this non-profit organization developed comprehensive sustainability standards for the products, producers, and handlers. This includes banning GMO’s/artificial flavors/preservatives, creating safe and fair working conditions, and reducing energy/water consumption.\n",
        "MSC" : "Marine Stewardship Council Blue Seafood: this independent, non-profit organization works with fisheries, scientists, conservation groups and stakeholders to set strict sustainability standards for fisheries.\n",
        "MBA": "Monterey Bay Seafood Watch \"Best Choice\" Seafood: is a consumer guide that labels fish species with a red, yellow or green tag that indicates the sustainability level of the fish’s specific supply chain. Green indicates the most sustainably caught and handled fish.\n",
        "PHC" :  "Protected Harvest Certified: this third party organization \"certifies that a producer has met region and crop-specific standards, as approved by its Sustainability Council.\"\n",
        "RAC" : "Rainforest Alliance Certified:  \"The Rainforest Alliance works to conserve biodiversity and improve livelihoods by promoting and evaluating the implementation of the most globally respected sustainability standards in a variety of fields.\"\n",
        "USDA" : "USDA Certified Organic: \"USDA defines specific organic standards that cover the product from farm to table, including soil and water quality, pest control, livestock practices, and rules for food additives.\" \n",
        "EFT": "Ecocert Fair Trade: requires their \"10 K.O. (Knock-Out) sustainability criteria\", which includes \"no practices violating human dignity, safe working conditions, and no actions threatening endangered species.\" \n",
        "FFS":  "Fair Food Standards Council: currently applied to Floridian tomato workers, this council seeks to advance basic worker human-rights by requiring improvements to worker safety and worker income.\n",
        "FL" : "Fair for Life: this certification mandates strict social and fair trade practices adapted to each local producer’s community. Transparent reporting increases their credibility.  \n",
        "FT" : "Fairtrade: a non-profit global organization that works with 1.2 million farmers in over 70 countries to promote sustainable farming, protect worker safety and make sure workers are fairly compensated. \n",
        "FW" : "FairWild Certified: this organization is dedicated to creating a framework for trading that requires application of sustainable wild plant collection, fair business transactions, and positively influences consumer decisions.\n",
        "FJC" : "Food Justice Certified: \"a label based on high-bar social justice standards for farms, processors, and retailers… ensuring fair treatment of workers, fair pricing for farmers, and fair business practices.\" To qualify, 95% of the dry ingredient weight must meet FJC standards.\n",
        "SPS" : "Small Producers’ Symbol: this initiative promotes sustainable growing/harvesting practices and fair prices to benefit the environment small communities in Latin America and the Caribbean.\n",
        "AGA":  "American Grassfed Association: this association set standards that require free range, grass-fed diets, and no antibiotics/hormones used on farm animals in addition to promoting healthy consumer diets. \n",
        "AHC": "American Humane Certified: as the first welfare certification program in America, this organization works to ensure humane treatment of farm animals by creating standards that improve animal living conditions. \n",
        "AWA": "Animal Welfare Approved: this certification works \"to maximize practicable, high-welfare farm management with the environment in mind\" by setting strict animal welfare standards.\n",
        "CHR" : "Certified Humane Raised and Handled: \"a national non-profit charity whose mission is to improve the lives of farm animals by providing viable, credible, and duly monitored standards for humane food production.\"\n",
        "GAP" : "Global Animal Partnership: a specific 5–step structure that \"promotes and facilitates continuous improvement in animal agriculture, encourages animal welfare friendly farming practices, and better informs consumers.\" \n",
 
        
        "CBFD": "Certified Bird Friendly coffee: this certification requires that the coffee is grown organically under a canopy of native trees, which avoids clear cutting, preserves migratory bird habitat, and improves carbon sequestration. \n",
        "CLSD": "Certified Local Sustainable (Local Food Plus): this non-profit organization set specific standards for sustainable farming that \"balance economic, social and environmental considerations.\" These include avoiding growth hormones, synthetic pesticides/fertilizers and reduce greenhouse emissions.\n",
        "IFOD": "International Federation of Organic Agriculture Movements: a non-profit organization that created a globally accepted standard for organic. Their mission is to promote more than just organic foods, but to also advance health, ecology, fairness, and care.\n",
        "DCBD" : "Demeter Certified Biodynamic: \"a comprehensive organic farming method that requires the creation and management of a closed system minimally dependent on imported materials, and instead meets its needs from the living dynamics of the farm itself.\" \n",
        "EUOD" : "European Union Organic: focuses on the entire supply chain to ensure every link along the chain adheres to strict regulations. They seek to indorse environmental protection, food quality, animal welfare and consumer confidence.\n",
        "FACD" : "Food Alliance Certified: this non-profit organization developed comprehensive sustainability standards for the products, producers, and handlers. This includes banning GMO’s/artificial flavors/preservatives, creating safe and fair working conditions, and reducing energy/water consumption.\n",
        "MSCD" : "Marine Stewardship Council Blue Seafood: this independent, non-profit organization works with fisheries, scientists, conservation groups and stakeholders to set strict sustainability standards for fisheries.\n",
        "MBAD": "Monterey Bay Seafood Watch \"Best Choice\" Seafood: is a consumer guide that labels fish species with a red, yellow or green tag that indicates the sustainability level of the fish’s specific supply chain. Green indicates the most sustainably caught and handled fish.\n",
        "PHCD" :  "Protected Harvest Certified: this third party organization \"certifies that a producer has met region and crop-specific standards, as approved by its Sustainability Council.\"\n",
        "RACD" : "Rainforest Alliance Certified:  \"The Rainforest Alliance works to conserve biodiversity and improve livelihoods by promoting and evaluating the implementation of the most globally respected sustainability standards in a variety of fields.\"\n",
        "USDAD" : "USDA Certified Organic: \"USDA defines specific organic standards that cover the product from farm to table, including soil and water quality, pest control, livestock practices, and rules for food additives.\" \n",
        "EFTD": "Ecocert Fair Trade: requires their \"10 K.O. (Knock-Out) sustainability criteria\", which includes \"no practices violating human dignity, safe working conditions, and no actions threatening endangered species.\" \n",
        "FFSD":  "Fair Food Standards Council: currently applied to Floridian tomato workers, this council seeks to advance basic worker human-rights by requiring improvements to worker safety and worker income.\n",
        "FLD" : "Fair for Life: this certification mandates strict social and fair trade practices adapted to each local producer’s community. Transparent reporting increases their credibility.  \n",
        "FTD" : "Fairtrade: a non-profit global organization that works with 1.2 million farmers in over 70 countries to promote sustainable farming, protect worker safety and make sure workers are fairly compensated. \n",
        "FWD" : "FairWild Certified: this organization is dedicated to creating a framework for trading that requires application of sustainable wild plant collection, fair business transactions, and positively influences consumer decisions.\n",
        "FJCD" : "Food Justice Certified: \"a label based on high-bar social justice standards for farms, processors, and retailers… ensuring fair treatment of workers, fair pricing for farmers, and fair business practices.\" To qualify, 95% of the dry ingredient weight must meet FJC standards.\n",
        "SPSD" : "Small Producers’ Symbol: this initiative promotes sustainable growing/harvesting practices and fair prices to benefit the environment small communities in Latin America and the Caribbean.\n",
        "AGAD":  "American Grassfed Association: this association set standards that require free range, grass-fed diets, and no antibiotics/hormones used on farm animals in addition to promoting healthy consumer diets. \n",
        "AHCD": "American Humane Certified: as the first welfare certification program in America, this organization works to ensure humane treatment of farm animals by creating standards that improve animal living conditions. \n",
        "AWAD": "Animal Welfare Approved: this certification works \"to maximize practicable, high-welfare farm management with the environment in mind\" by setting strict animal welfare standards.\n",
        "CHRD" : "Certified Humane Raised and Handled: \"a national non-profit charity whose mission is to improve the lives of farm animals by providing viable, credible, and duly monitored standards for humane food production.\"\n",
        "GAPD" : "Global Animal Partnership: a specific 5–step structure that \"promotes and facilitates continuous improvement in animal agriculture, encourages animal welfare friendly farming practices, and better informs consumers.\" \n",
    ]
    
    let urls = [
        "FS":  "http://food.davidsonsustainability.org",
        "L":  "http://food.davidsonsustainability.org",
        "SE": "http://food.davidsonsustainability.org",
        "FSD": "http://food.davidsonsustainability.org",
        "AI":  "http://food.davidsonsustainability.org",
        "CA":  "http://food.davidsonsustainability.org",
        "FD":  "http://food.davidsonsustainability.org",
        "MD":  "http://food.davidsonsustainability.org",
        "VO":  "http://food.davidsonsustainability.org",
        "C":  "http://food.davidsonsustainability.org",
        "LA":  "http://food.davidsonsustainability.org",
        "R":  "http://food.davidsonsustainability.org",
        "LD": "http://food.davidsonsustainability.org",
        "CE":  "http://food.davidsonsustainability.org",
        "ES":  "http://food.davidsonsustainability.org",
        "HF":  "http://food.davidsonsustainability.org",
        "PP":  "http://food.davidsonsustainability.org",
        "VN":  "http://food.davidsonsustainability.org",
        
        "Humane": "http://food.davidsonsustainability.org",
        "Eco": "http://food.davidsonsustainability.org",
        "Fair": "http://food.davidsonsustainability.org",
        
        "COB": "http://food.davidsonsustainability.org",
        "CBF": "http://food.davidsonsustainability.org",
        "CLS": "http://food.davidsonsustainability.org",
        "IFO": "http://food.davidsonsustainability.org",
        "DCB" : "http://food.davidsonsustainability.org",
        "EUO" : "http://food.davidsonsustainability.org",
        "FAC" : "http://food.davidsonsustainability.org",
        "MSC" : "http://food.davidsonsustainability.org",
        "MBA": "http://food.davidsonsustainability.org",
        "PHC" :  "http://food.davidsonsustainability.org",
        "RAC" : "http://food.davidsonsustainability.org",
        "USDA" : "http://food.davidsonsustainability.org",
        "EFT": "http://food.davidsonsustainability.org",
        "FFS":  "http://food.davidsonsustainability.org",
        "FL" : "http://food.davidsonsustainability.org",
        "FT" : "http://food.davidsonsustainability.org",
        "FW" : "http://food.davidsonsustainability.org",
        "FJC" : "http://food.davidsonsustainability.org",
        "SPS" : "http://food.davidsonsustainability.org",
        "AGA":  "http://food.davidsonsustainability.org",
        "AHC": "http://food.davidsonsustainability.org",
        "AWA": "http://food.davidsonsustainability.org",
        "CHR" : "http://food.davidsonsustainability.org",
        "GAP" : "http://food.davidsonsustainability.org",
        
        "COBD": "http://food.davidsonsustainability.org",
        "CBFD": "http://food.davidsonsustainability.org",
        "CLSD": "http://food.davidsonsustainability.org",
        "IFOD": "http://food.davidsonsustainability.org",
        "DCBD":  "http://food.davidsonsustainability.org",
        "EUOD": "http://food.davidsonsustainability.org",
        "FACD": "http://food.davidsonsustainability.org",
        "MSCD": "http://food.davidsonsustainability.org",
        "MBAD": "http://food.davidsonsustainability.org",
        "PHCD": "http://food.davidsonsustainability.org",
        "RACD": "http://food.davidsonsustainability.org",
        "USDAD": "http://food.davidsonsustainability.org",
        "EFTD": "http://food.davidsonsustainability.org",
        "FFSD": "http://food.davidsonsustainability.org",
        "FLD": "http://food.davidsonsustainability.org",
        "FTD": "http://food.davidsonsustainability.org",
        "FWD": "http://food.davidsonsustainability.org",
        "FJCD": "http://food.davidsonsustainability.org",
        "SPSD": "http://food.davidsonsustainability.org",
        "AGAD": "http://food.davidsonsustainability.org",
        "AHCD": "http://food.davidsonsustainability.org",
        "AWAD": "http://food.davidsonsustainability.org",
        "CHRD": "http://food.davidsonsustainability.org",
        "GAPD": "http://food.davidsonsustainability.org"
    ]
}