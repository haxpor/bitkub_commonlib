#include "bitkub_commonlib.h"

#include <unistd.h>
#include <cstring>
#include <cstdio>

namespace bitkub
{

const bool g_supportTTY = isatty(STDOUT_FILENO);

bool FoundCmdOption(int argc, char* argv[], const char* option, int* outArgvIndex)
{
	for (int i=1; i<argc; ++i)
	{
		if (std::strcmp(argv[i], option) == 0)
		{
			if (outArgvIndex)
				*outArgvIndex = i;
			return true;
		}
	}
	return false;
}

void ComputeProfit(double amountToSpend, double cryptoBuyPrice, double cryptoSellPrice, double& grossProfit, double& netProfit, IntermediatedArtifactsProfit* artifacts)
{
	double buyFee = amountToSpend * kFeePercentage;
	double grossAmountGainedCRYPTO = amountToSpend / cryptoBuyPrice;
	double netAmountGainedCRYPTO = (amountToSpend - buyFee) / cryptoBuyPrice;

	double grossSellVol = grossAmountGainedCRYPTO * cryptoSellPrice;
	// sell fee needs to be deducted from crypto amount, not total sell price
	double sellFee_cryptoAmount = netAmountGainedCRYPTO * kFeePercentage;
	double netSellVol = (netAmountGainedCRYPTO - sellFee_cryptoAmount) * cryptoSellPrice;
	
	grossProfit = grossSellVol - amountToSpend;
	netProfit = netSellVol - amountToSpend;

	if (artifacts != nullptr)
	{
		artifacts->buyFee = buyFee;
		artifacts->grossAmountGainedCrypto = grossAmountGainedCRYPTO;
		artifacts->netAmountGainedCrypto = netAmountGainedCRYPTO;
		artifacts->grossSellVolume = grossSellVol;
		artifacts->sellFeeCryptoAmount = sellFee_cryptoAmount;
		artifacts->netSellVolume = netSellVol;
	}
}

} // namespace bitkub
